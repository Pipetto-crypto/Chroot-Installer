#!/bin/bash

cd ~
echo -e "\nInstalling all dependencies and setting up storage permissions\n"

pkg update
pkg install x11-repo root-repo -y
pkg install pulseaudio bindfs tsu openssh openssl xwayland bc megatools mount-utils git mesa virglrenderer-android -y

if [ ! -d ~/storage ]
then
    termux-setup-storage
fi

git clone https://github.com/Pipetto-crypto/Chroot-Installer.git
cd Chroot-Installer
