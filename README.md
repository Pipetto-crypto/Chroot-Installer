# Chroot-Installer

A script to install chroot containers on Android with termux. Most of this README is a WIP

Full installation of a container:

bash chroot-installer install Ubuntu ubuntu -b -d

Run the container:

bash chroot-installer start 

Run the container with Termux:X11 and virglrenderer-android:

bash chroot-installer start -x -va

Stop the container:

bash chroot-installer stop

