#!/bin/bash

VERSION=7.5
ARCH=amd64

echo -e "Adding armhf architechture"

sudo dpkg --add-architecture armhf
sudo apt update

echo -e "Installing required dependencies dependencies"

sudo apt install zenity:armhf libasound*:armhf libstdc++6:armhf mesa*:armhf -y
sudo apt install mesa* zenity* gcc-multilib-x86-64-linux-gnu -y

echo -e "Installing box86 and box64"

sudo wget https://ryanfortner.github.io/box64-debs/box64.list -O /etc/apt/sources.list.d/box64.list
wget -O- https://ryanfortner.github.io/box64-debs/KEY.gpg | sudo gpg --dearmor -o /usr/share/keyrings/box64-debs-archive-keyring.gpg 
sudo apt update && sudo apt install box64 -y
sudo wget https://itai-nelken.github.io/weekly-box86-debs/debian/box86.list -O /etc/apt/sources.list.d/box86.list
wget -qO- https://itai-nelken.github.io/weekly-box86-debs/debian/KEY.gpg | sudo apt-key add -
sudo apt update && sudo apt install box86 -y
sudo ln /usr/local/bin/box86 /usr/bin/box86
sudo ln /usr/local/bin/box64 /usr/bin/box64

echo -e "Installing wine"

wget https://github.com/Kron4ek/Wine-Builds/releases/download/$VERSION/wine-$VERSION-$ARCH.tar.xz
tar -xvf wine-$VERSION-$ARCH.tar.xz
mv wine-$VERSION-$ARCH wine

echo "export PATH=$PATH:~/wine64/bin" >> $HOME/.bashrc

echo -e "Installing bash_x86 and bash_x64"

wget https://github.com/Pipetto-crypto/Chroot-Docs/raw/main/box-wine/bash_x64
wget https://github.com/Pipetto-crypto/Chroot-Docs/raw/main/box-wine/bash_x86
mkdir -p $HOME/box_bash
sudo chmod +x bash_x64 bash_x86
mv bash_x64 $HOME/box_bash
mv bash_x86 $HOME/box_bash


echo -e "Installing winetricks"

wget https://raw.githubusercontent.com/Pipetto-crypto/Chroot-Docs/main/box-wine/winetricks
sudo mv winetricks /usr/bin
sudo chmod +x /usr/bin/winetricks

echo -e "Cleaning up"

sudo rm -rf *.tar.gz

