#!/bin/bash

#Variables

ARCH=$(uname -m)
OPMODES=$(lscpu | grep  "CPU op-mode" | awk -F ":" '{print $2}')
VERSION=7.1


if [ "$ARCH" == "armv7l" ] || [ "$ARCH" == "armv8l" ] || [ "$ARCH" == "aarch64" ]
then

echo -e "\nInstalling box86"

sudo dpkg --add-architecture armhf
sudo apt update
sudo apt install mesa-*:armhf zenity:armhf libasound*:armhf libstdc++6:armhf -y
sudo wget https://ryanfortner.github.io/box86-debs/box86.list -O /etc/apt/sources.list.d/box86.list
wget -qO- https://ryanfortner.github.io/box86-debs/KEY.gpg | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/box86-debs-archive-keyring.gpg 
sudo apt update && sudo apt install box86-android:armhf -y
sudo ln -f /usr/local/bin/box86 /usr/bin/box86

fi

if [ "$ARCH" == "aarch64" ] || [ "$(echo $OPMODES)" == "32-bit, 64-bit" ]
then

echo -e "\nInstalling box64"
IS64BIT="true"
sudo apt install mesa-* zenity* gcc-multilib-x86-64-linux-gnu bc file xz-utils -y
sudo wget https://ryanfortner.github.io/box64-debs/box64.list -O /etc/apt/sources.list.d/box64.list
wget -qO- https://ryanfortner.github.io/box64-debs/KEY.gpg | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/box64-debs-archive-keyring.gpg 
sudo apt update && sudo apt install box64-android -y
sudo ln -f /usr/local/bin/box64 /usr/bin/box64

fi

echo -e "\nCopying wine wrappers and winswitch script, installing wine"

mkdir -p $HOME/.local/wineprefix
mkdir -p $HOME/.local/wineprefix64
sudo mv $HOME/scripts/wineswitch  $HOME/scripts/wine $HOME/scripts/wine64 /usr/bin
sudo chmod +x /usr/bin/wineswitch /usr/bin/wine /usr/bin/wine64
wineswitch $VERSION uni

echo -e "\nCopying install_dxvk and remove_dxvk scripts"

sudo mv $HOME/scripts/install_dxvk $HOME/scripts/remove_dxvk /usr/bin
sudo chmod +x /usr/bin/install_dxvk /usr/bin/remove_dxvk

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
