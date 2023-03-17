#!/bin/bash

# PID=$(pgrep gnome-session|head -n 1)
# export DBUS_SESSION_BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$PID/environ)

PID=$(pgrep -f 'gnome-session' | head -n1)
export DBUS_SESSION_BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$PID/environ | cut -d= -f2- ) 

PIC=$(find ~/Pictures/Walls/ -type f| shuf -n 1)
gsettings set org.gnome.desktop.background picture-uri-dark "file:///$PIC"
