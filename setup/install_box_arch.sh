#!/bin/bash

VERSION=7.5
ARCH=amd64


echo -e "Installing required dependencies dependencies"

sudo pacman -S base-devel git cmake python3 --needed --noconfirm

echo -e "Installing box64"

if ! ls -l /usr/local/bin/box64 | grep box64
then
	git clone https://github.com/ptitSeb/box64.git
	cd box64
	mkdir build
	cd build
	cmake .. -DRPI4ARM64=1 -DCMAKE_BUILD_TYPE=RelWithDebInfo
	make -j$(nproc --all)
	sudo make install
	cd ~
fi

echo -e "Installing wine64 and wine"

wget https://github.com/Kron4ek/Wine-Builds/releases/download/$VERSION/wine-$VERSION-$ARCH.tar.xz
tar -xvf wine-$VERSION-$ARCH.tar.xz
mv wine-$VERSION-$ARCH wine64

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

sudo rm -rf *.tar.gz box64

