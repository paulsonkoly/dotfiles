#!/bin/bash

setxkbmap gb
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
[[ -f ~/.Xdefaults ]] && xrdb -merge -I$HOME ~/.Xdefaults

source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh

# background jpg
feh --bg-fill $HOME/Downloads/tarun-ram-454974.jpg

# exec dwm
exec i3
