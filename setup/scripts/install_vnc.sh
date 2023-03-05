#!/bin/bash

mkdir -p $HOME/.vnc
touch $HOME/.vnc/xstartup
sudo chmod +x $HOME/.vnc/xstartup
echo "unset SESSION_MANAGER" > $HOME/.vnc/xstartup
echo "unset DBUS_SESSION_BUS_ADDRESS" >> $HOME/.vnc/xstartup
if ls /usr/bin | grep -q startlxqt
then
	echo "exec dbus-launch --exit-with-session startlxqt" >> $HOME/.vnc/xstartup
elif ls /usr/bin | grep -q xfce4-session
then
	echo "exec dbus-launch --exit-with-session xfce4-session" >> $HOME/.vnc/xstartup
elif ls /usr/bin | grep -q fluxbox
then
	echo "exec dbus-launch --exit-with-session fluxbox" >> $HOME/.vnc/xstartup
else
	echo "exec dbus-launch --exit-with-session icewm" >> $HOME/.vnc/xstartup
fi
echo "[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup" >> $HOME/.vnc/xstartup
echo "[ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources" >> $HOME/.vnc/xstartup
echo "xsetroot -solid grey" >> $HOME/.vnc/xstartup
echo "vncconfig -iconic &" >> $HOME/.vnc/xstartup
