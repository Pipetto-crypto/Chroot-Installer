#!/bin/bash

if ls $CHROOT_DIR/usr/bin | grep -wq "apt$"                                             
then
     PACKAGEMANAGER=apt                                                                  

elif ls $CHROOT_DIR/usr/bin | grep -wq "pacman$"
then
     PACKAGEMANAGER=pacman                                                               
fi

read -p "Select a DE among the available choices[xfce|lxqt|icewm|fluxbox]: " DE
case "$DE" in
xfce)
    case "$PACKAGEMANAGER" in
    apt)
         sudo apt install tigervnc-standalone-server tigervnc-common dbus-x11 tigervnc-xorg-extension xfce4 xfce4-goodies xvfb xwayland -y
         ;;
    pacman)
         sudo pacman -S --noconfirm tigervnc dbus xfce4 xfce4-goodies xorg-server-xvfb xorg-xwayland
         ;;   
   esac
   ;;
lxqt)
    case "$PACKAGEMANAGER" in
    apt)
        sudo apt install tigervnc-standalone-server tigervnc-common dbus-x11 xvfb xwayland tigervnc-xorg-extension lxqt -y
        ;;
    pacman)
        sudo pacman -S --noconfirm xorg-server-xvfb xorg-xwayland tigervnc dbus lxqt papirus-icon-theme breeze-icons
        ;;
   esac
   ;;
icewm)
    case "$PACKAGEMANAGER" in 
    apt)
        sudo apt install tigervnc-standalone-server xvfb xwayland tigervnc-common dbus-x11 tigervnc-xorg-extension icewm -y
        ;;
    pacman)
        sudo pacman -S --noconfirm xorg-server-xvfb xorg-xwayland tigervnc dbus icewm xorg-fonts-misc xterm
        ;;
   esac
   ;;
fluxbox)
     case "$PACKAGEMANAGER" in
     apt)
         sudo apt install xwayland xvfb tigervnc-standalone-server tigervnc-common dbus-x11 tigervnc-xorg-extension fluxbox xterm -y 
         ;;
     pacman)
         sudo pacman -S --noconfirm xorg-server-xvfb xorg-xwayland tigervnc dbus fluxbox xterm 
         ;;
    esac
    ;;
esac

mkdir -p $HOME/.vnc
touch $HOME/.vnc/xstartup
sudo chmod +x $HOME/.vnc/xstartup
echo "unset SESSION_MANAGER" > $HOME/.vnc/xstartup
echo "unset DBUS_SESSION_BUS_ADDRESS" >> $HOME/.vnc/xstartup
case "$DE" in
lxqt)
	echo "exec dbus-launch --exit-with-session startlxqt" >> $HOME/.vnc/xstartup
        ;;
xfce)
	echo "exec dbus-launch --exit-with-session xfce4-session" >> $HOME/.vnc/xstartup
        ;;
fluxbox)
	echo "exec dbus-launch --exit-with-session fluxbox" >> $HOME/.vnc/xstartup
        ;;
icewm)
	echo "exec dbus-launch --exit-with-session icewm" >> $HOME/.vnc/xstartup
        ;;
esac
echo "[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup" >> $HOME/.vnc/xstartup
echo "[ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources" >> $HOME/.vnc/xstartup
echo "xsetroot -solid grey" >> $HOME/.vnc/xstartup
echo "vncconfig -iconic &" >> $HOME/.vnc/xstartup
