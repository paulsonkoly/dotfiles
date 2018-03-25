#!/bin/bash

setxkbmap gb
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh

# start information system
cd $HOME/notify && bundle exec app/stuff.rb &

wal -R
dunst.sh &

# exec dwm
exec i3
