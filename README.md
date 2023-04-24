# Chroot-Installer

A script to install chroot containers on Android through Termux. This README is like this installer mostly a huge WIP and some stuffs don't work correctly yet.

# Requirments

You need to have busybox installed and accesible. Termux:X11 is not a requirment as you can use VNC but it is highly recommended to install it from links.

# Basic Usage

First installation of a container named Ubuntu in which installing Ubuntu distribution with box86/64(-b) and a DE(-d):

bash chroot-installer install Ubuntu ubuntu -b -d

Run the previously installed container:

chroot-installer start | if it's the only one installed or the one you want to launch is the default one

chroot-installer start Ubuntu | if you have more than one installed and the one you want to start isn't the default 

Run the container with Termux:X11/XVFB and virglrenderer-android:

chroot-installer start -x -va

Run the container with Termux:X11/Xwayland and virglrenderer-android:

chroot-installer start -w -va

Stop the container:

bash chroot-installer stop

Some of the sepcific commands you can execute inside the chroot can be found in the "Useful proot commands" section of the project in the links.

For now supported distributions are Debian, Ubuntu, Arch and Manjaro but Debian doesn't have hardware acceleration apart from Turnip/DXVK and Manjaro and Arch may have some minor random issues when installing 

# Credits and Links

This script is the chroot version of my other project so credits and links are similiar

https://github.com/Pipetto-crypto/3in1ProotX86Emus
