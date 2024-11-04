#!/bin/bash

selected=$(echo "󰝰  Files Manager
  Setting
  Disk Usage
󰃢  Cleaner" | rofi -dmenu  -p "  " -theme menu -i)

case "$selected" in
  "󰝰  Files Manager") nautilus --no-desktop;;
  "  Setting") gnome-control-center ;;
  "  Disk Usage") baobab;;
  "󰃢  Cleaner") ubuntu-cleaner;;
  *) exit 1 ;;
esac
