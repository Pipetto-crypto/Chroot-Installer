#!/bin/bash

#Variables


VERSION=7.5
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
		cmake .. -DRPI4ARM64=1 -DCMAKE_BUILD_TYPE=RelWithDebInfo
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
		cmake .. -DRPI4=1 -DCMAKE_BUILD_TYPE=RelWithDebInfo 
		make -j4
		sudo make install
		cd ~
		sudo ln -f /usr/local/bin/box86 /usr/bin/box86
	fi
fi




echo -e "Installing wine"

wget https://github.com/Kron4ek/Wine-Builds/releases/download/$VERSION/wine-$VERSION-$WINEARCH.tar.xz
tar -xvf wine-$VERSION-$WINEARCH.tar.xz
mv wine-$VERSION-$WINEARCH wine64

echo "export PATH=$PATH:~/wine64/bin" >> $HOME/.bashrc

echo -e "Installing bash_x86 and bash_x64"

wget https://github.com/Pipetto-crypto/Chroot-Docs/raw/main/box-wine/bash_x64 
mkdir -p $HOME/box_bash
sudo chmod +x bash_x64
mv bash_x64 $HOME/box_bash

echo -e "Installing winetricks"

wget https://raw.githubusercontent.com/Pipetto-crypto/Chroot-Docs/main/box-wine/winetricks
sudo mv winetricks /usr/bin
sudo chmod +x /usr/bin/winetricks

echo -e "Cleaning up"

sudo rm -rf *.tar.xz box64

