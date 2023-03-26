#!/bin/bash

#Variables

ARCH=$(uname -m)
OPMODES=$(lscpu | grep  "CPU op-mode" | awk -F ":" '{print $2}')
VERSION=7.1
WINEARCH=amd64


if [ "$ARCH" == "armv7l" ] || [ "$ARCH" == "armv8l" ] || [ "$ARCH" == "aarch64" ]
then

echo -e "\nInstalling box86"

sudo dpkg --add-architecture armhf
sudo apt update
sudo apt install zenity:armhf libasound*:armhf libstdc++6:armhf -y
sudo wget https://ryanfortner.github.io/box86-debs/box86.list -O /etc/apt/sources.list.d/box86.list
wget -qO- https://ryanfortner.github.io/box86-debs/KEY.gpg | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/box86-debs-archive-keyring.gpg 
sudo apt update && sudo apt install box86-android:armhf -y

fi

if [ "$ARCH" == "aarch64" ] || [ "$(echo $OPMODES)" == "32-bit, 64-bit" ]
then

echo -e "\nInstalling box64"

sudo apt install zenity* gcc-multilib-x86-64-linux-gnu -y
sudo wget https://ryanfortner.github.io/box64-debs/box64.list -O /etc/apt/sources.list.d/box64.list
wget -qO- https://ryanfortner.github.io/box64-debs/KEY.gpg | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/box64-debs-archive-keyring.gpg 
sudo apt update && sudo apt install box64-android -y

fi


echo -e "\nSetting env variables"

echo "export BOX86_PATH=~/wine$VERSION/bin/" | sudo tee -a /etc/profile >/dev/null 2>&1
echo "export BOX86_LD_LIBRARY_PATH=~/wine$VERSION/lib/wine/i386-unix/:/lib/i386-linux-gnu:/lib/aarch64-linux-gnu/" | sudo tee -a /etc/profile >/dev/null 2>&1
echo "export BOX64_PATH=~/wine$VERSION/bin/" | sudo tee -a /etc/profile >/dev/null 2>&1
echo "export BOX64_LD_LIBRARY_PATH=~/wine$VERSION/lib/wine/i386-unix/:~/wine$VERSION/lib/wine/x86_64-unix/:/lib/i386-linux-gnu/:/lib/x86_64-linux-gnu:/lib/aarch64-linux-gnu:/usr/x86_64-linux-gnu/lib" | sudo tee -a  /etc/profile >/dev/null 2>&1
echo "export BOX86_BASH=~/box_bash/bash_x86" | sudo tee -a /etc/profile >/dev/null 2>&1
echo "export BOX64_BASH=~/box_bash/bash_x64" | sudo tee -a /etc/profile >/dev/null 2>&1
echo "export WINEPREFIX=~/.local/wineprefixes/wine$VERSION" | sudo tee -a /etc/profile >/dev/null 2>&1

echo -e "\nInstalling wine"


wget https://github.com/Kron4ek/Wine-Builds/releases/download/$VERSION/wine-$VERSION-$WINEARCH.tar.xz
tar -xvf wine-$VERSION-$WINEARCH.tar.xz
mv wine-$VERSION-$WINEARCH wine$VERSION
mkdir -p ~/.local/wineprefixes

echo -e "\nInstalling bash_x86 and bash_x64"

mkdir -p $HOME/box_bash
sudo chmod +x scripts/bash_x64 scripts/bash_x86
mv scripts/bash_x64 $HOME/box_bash
mv scripts/bash_x86 $HOME/box_bash


echo -e "\nInstalling winetricks"

sudo mv scripts/winetricks /usr/bin
sudo chmod +x /usr/bin/winetricks

echo -e "\nCleaning up"

sudo rm -rf *.tar.xz
