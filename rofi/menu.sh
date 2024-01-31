#!/bin/bash

selected=$(echo "󰝰  Files Explorer
  Setting
󰨣  Disk Usage" | rofi -dmenu  -p ">>" -theme menu -i)

case "$selected" in
  "󰝰  Files Explorer") nautilus --no-desktop;;
  "  Setting") gnome-control-center ;;
  "󰨣  Disk Usage") baobab;;
  *) exit 1 ;;
esac
