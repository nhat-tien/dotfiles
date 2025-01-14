#!/bin/bash

icat --detect-support &> /dev/null
status_code=$?
if [ "$status_code" -eq 0 ]; then
  if [[ -f  $HOME/dotfiles/bluemouse.png ]]; then
    icat --place 25x25@0x0 $HOME/dotfiles/bluemouse.png
    printf '\n\n\n\n\n\n\n\n'
  fi
fi

