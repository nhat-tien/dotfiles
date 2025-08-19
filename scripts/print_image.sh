#!/usr/bin/env bash

image_path="$DOTFILES_ASSETS/bluemouse.png"

kitty_ter() {

    icat --detect-support &> /dev/null

    status_code=$?

    if [ "$status_code" -eq 0 ]; then
      icat --place 25x25@0x0 "$image_path"
      printf '\n\n\n\n\n\n\n\n'
    fi
}

wezterm_ter() {
    wezterm imgcat --resize 220x220 "$image_path"
}

if [[ -f "$image_path" ]]; then

  term=$(ps -p $(ps -o ppid= -p $$) -o comm=)

  case "$term" in
    "kitty")
      kitty_ter 
      ;;
    "wezterm-gui")
      wezterm_ter
      ;;
  esac
fi



