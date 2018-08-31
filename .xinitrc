#!/bin/bash

setxkbmap gb
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh

start-pulseaudio-x11

# annoying bell off
xset b off

wal -R
dunst.sh &

exec i3
