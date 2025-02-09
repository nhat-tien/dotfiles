#!/bin/bash

icat --detect-support &> /dev/null

status_code=$?

kitty_ter() {
    icat --place 25x25@0x0 $HOME/dotfiles/bluemouse.png
    printf '\n\n\n\n\n\n\n\n'
}
wezterm_ter() {
    wezterm imgcat --resize 220x220 $HOME/dotfiles/bluemouse.png
}

if [ "$status_code" -eq 0 ]; then
    if [[ -f  $HOME/dotfiles/bluemouse.png ]]; then
      kitty_ter 
    fi
fi



