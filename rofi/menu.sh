#!/bin/bash

selected=$(echo "󰝰  Files Explorer
  Setting
  Disk Usage
󰃢  Cleaner" | rofi -dmenu  -p "  " -theme menu -i)

case "$selected" in
  "󰝰  Files Explorer") nautilus --no-desktop;;
  "  Setting") gnome-control-center ;;
  "  Disk Usage") baobab;;
  "󰃢  Cleaner") ubuntu-cleaner;;
  *) exit 1 ;;
esac
