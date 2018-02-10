#!/usr/bin/env bash
_INPUT_FILE=$(mktemp)
# -f to run gvim in the foreground outherwise it forks
gvim -f -c "set noswapfile" "$_INPUT_FILE"

sleep 0.2

# strip last byte, the newline. https://stackoverflow.com/a/12579554
head -c -1 $_INPUT_FILE | xdotool type --clearmodifiers --delay 0 --file -
rm $_INPUT_FILE
