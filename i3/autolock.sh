#!/usr/bin/env bash
killall -q xautolock

xautolock -detectsleep -time 5 -locker "i3lock -i ~/dotfiles/wallpapers/wallpaperblur.png"


