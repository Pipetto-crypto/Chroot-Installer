#!/bin/bash

#Variables


VERSION=7.1
WINEARCH=amd64
ARCH=$(uname -m)
OPMODES=$(lscpu | grep  "CPU op-mode" | awk -F ":" '{print $2}')

echo -e "Installing required dependencies dependencies"

sudo pacman -S base-devel git cmake python3 --needed --noconfirm

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
		sudo ln -f /usr/local/bin/box64 /usr/bin/box64
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
		sudo ln -f /usr/local/bin/box86 /usr/bin/box86
	fi
fi


echo -e "Setting up env"

echo "export BOX86_PATH=~/wine$VERSION/bin/" | sudo tee -a /etc/profile >/dev/null 2>&1                                                                                                  
echo "export BOX86_LD_LIBRARY_PATH=~/wine$VERSION/lib/wine/i386-unix/:/lib/i386-linux-gnu:/lib/aarch64-linux-gnu/" | sudo tee -a /etc/profile >/dev/null 2>&1
echo "export BOX64_PATH=~/wine$VERSION/bin/" | sudo tee -a /etc/profile >/dev/null 2>&1
echo "export BOX64_LD_LIBRARY_PATH=~/wine$VERSION/lib/wine/i386-unix/:~/wine$VERSION/lib/wine/x86_64-unix/:/lib/i386-linux-gnu/:/lib/x86_64-linux-gnu:/lib/aarch64-linux-gnu:/usr/x86_64-linux-gnu/lib"  | sudo tee -a /etc/profile >/dev/null 2>&1 
echo "export BOX86_BASH=~/box_bash/bash_x86" | sudo tee -a /etc/profile >/dev/null 2>&1
echo "export BOX64_BASH=~/box_bash/bash_x64" | sudo tee -a /etc/profile >/dev/null 2>&1
echo "export WINEPREFIX=~/.local/wineprefixes/wine$VERSION" | sudo tee -a /etc/profile >/dev/null 2>&1

echo -e "Installing wine"

wget https://github.com/Kron4ek/Wine-Builds/releases/download/$VERSION/wine-$VERSION-$WINEARCH.tar.xz
tar -xvf wine-$VERSION-$WINEARCH.tar.xz
mv wine-$VERSION-$WINEARCH wine$VERSION
mkdir -p ~/.local/wineprefixes



echo -e "Installing bash_x86 and bash_x64"

mkdir -p $HOME/box_bash
sudo chmod +x scripts/bash_x64
mv scripts/bash_x64 $HOME/box_bash

echo -e "Installing winetricks"

sudo mv scripts/winetricks /usr/bin
sudo chmod +x /usr/bin/winetricks

echo -e "Cleaning up"

sudo rm -rf *.tar.xz scripts


