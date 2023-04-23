# Chroot-Installer

A script to install chroot containers on Android with termux. Most of this README is a WIP

Installation of a container named Ubuntu where you want to install Ubuntu distribution with box86/64(-b) and a DE(-d):

bash chroot-installer install Ubuntu ubuntu -b -d

Run the previously installed container:

bash chroot-installer start | if it's the only one installed or the one you want to launch is the default one
bash chroot-installer start Ubuntu | if you have more than one installed and the one you want to start isn't the default 

Run the container with Termux:X11/XVFB and virglrenderer-android:

bash chroot-installer start -x -va

Run the container with Termux:X11/Xwayland and virglrenderer-android:

bash chroot-installer start -w -va

Stop the container:

bash chroot-installer stop

