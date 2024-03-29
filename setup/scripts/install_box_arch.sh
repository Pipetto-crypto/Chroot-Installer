#!/bin/bash

#Variables


VERSION=7.1
ARCH=$(uname -m)
OPMODES=$(lscpu | grep  "CPU op-mode" | awk -F ":" '{print $2}')

echo -e "Installing required dependencies dependencies"

sudo pacman -S mesa zenity alsa-lib base-devel git cmake python3 bc file xz --needed --noconfirm

if [ "$ARCH" == "aarch64" ] || [ "$(echo $OPMODES)" == "32-bit, 64-bit" ]
then
	echo -e "Installing box64"

	if ! ls -l /usr/local/bin | grep -q box64
	then
		git clone https://github.com/ptitSeb/box64.git
		cd box64
		mkdir build
		cd build
		cmake .. -DRPI4ARM64=1 -DCMAKE_BUILD_TYPE=RelWithDebInfo -DBAD_SIGNAL=ON
		make -j4
		sudo make install
		cd ~
	fi
else
	if ! ls -l /usr/local/bin | grep -q box86
	then
		git clone https://github.com/ptitSeb/box86
		cd box86
		mkdir build
		cd build
		cmake .. -DRPI4=1 -DCMAKE_BUILD_TYPE=RelWithDebInfo -DBAD_SIGNAL=ON
		make -j4
		sudo make install
		cd ~
	fi
fi


if [ "$ARCH" == "armv7l" ] 
then
     echo -e "Installing wine with wineswitch script"
     mkdir -p $HOME/.local/wineprefix
     sudo wineswitch $VERSION x86
fi

echo -e "Installing bash_x86 and bash_x64"

mkdir -p $HOME/box_bash
sudo chmod +x scripts/bash_x64
mv scripts/bash_x64 $HOME/box_bash

if [ "$ARCH" == "armv7l" ]
then
     echo -e "Installing winetricks"
     sudo mv scripts/winetricks /usr/bin
     sudo chmod +x /usr/bin/winetricks
fi

echo -e "Cleaning up"

sudo rm -rf *.tar.xz


