#!/bin/bash

echo -e "\nInstalling all dependencies and setting up storage permissions\n"

pkg update
pkg install x11-repo root-repo -y
pkg install pulseaudio bindfs tsu openssh openssl xwayland bc megatools mount-utils git mesa virglrenderer-android -y

if [ ! -d ~/storage ]
then
    termux-setup-storage
fi

echo -e "TODO: Automatic installation of Termux:X11, automatic clone of the repository"
