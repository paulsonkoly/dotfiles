#!/bin/bash

setxkbmap gb
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
[[ -f ~/.Xdefaults ]] && xrdb -merge -I$HOME ~/.Xdefaults

source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh

# start information system
cd $HOME/notify && bundle exec app/stuff.rb &

wal -i Downloads/wallhaven-623995.jpg

# exec dwm
exec i3
