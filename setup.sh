#!/bin/bash


echo -e "\nInstalling all dependencies and setting up storage permissions\n"

pkg update
pkg install x11-repo root-repo -y
pkg install pulseaudio bindfs tsu openssh openssl xwayland megatools mount-utils git -y

if [ ! -d ~/storage ]
then
    termux-setup-storage
fi
