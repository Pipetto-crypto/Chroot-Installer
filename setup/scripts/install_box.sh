#!/bin/bash

#Variables

ARCH=$(uname -m)
OPMODES=$(lscpu | grep  "CPU op-mode" | awk -F ":" '{print $2}')
VERSION=7.5
WINEARCH=amd64


if [ "$ARCH" == "armv7l" ] || [ "$ARCH" == "armv8l" ] || [ "$ARCH" == "aarch64" ]
then

echo -e "\nInstalling box86"

sudo dpkg --add-architecture armhf
sudo apt update
sudo apt install zenity:armhf libasound*:armhf libstdc++6:armhf mesa*:armhf -y
PATH=$PATH:/usr/local/sbin:/usr/sbin:/sbin sudo dpkg -i ~/scripts/box86_0.3.0_armhf.deb

fi

if [ "$ARCH" == "aarch64" ] || [ "$(echo $OPMODES)" == "32-bit, 64-bit" ]
then

echo -e "\nInstalling box64"

sudo apt install mesa* zenity* gcc-multilib-x86-64-linux-gnu -y
PATH=$PATH:/usr/local/sbin:/usr/sbin:/sbin sudo dpkg -i ~/scripts/box64_0.2.2_arm64.deb

fi

echo -e "\nInstalling wine"



wget https://github.com/Kron4ek/Wine-Builds/releases/download/$VERSION/wine-$VERSION-$WINEARCH.tar.xz
tar -xvf wine-$VERSION-$WINEARCH.tar.xz
mv wine-$VERSION-$WINEARCH wine
echo "alias win32='WINEPREFIX=~/.wine32 WINEARCH=win32'" >> $HOME/.bashrc
echo "export PATH=$PATH:~/wine/bin:~/wine/bin" >> $HOME/.bashrc


echo -e "\nInstalling bash_x86 and bash_x64"

mkdir -p $HOME/box_bash
sudo chmod +x scripts/bash_x64 scripts/bash_x86
mv scripts/bash_x64 $HOME/box_bash
mv scripts/bash_x86 $HOME/box_bash


echo -e "\nInstalling winetricks"

sudo mv scripts/winetricks /usr/bin
sudo chmod +x /usr/bin/winetricks

echo -e "\nCleaning up"

sudo rm -rf *.tar.gz
