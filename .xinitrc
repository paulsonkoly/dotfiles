#!/bin/bash

# RVM paths need to be exported here so bin/stuff works
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

setxkbmap gb
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh

start-pulseaudio-x11

# annoying bell off
xset b off

wal -R

exec i3
