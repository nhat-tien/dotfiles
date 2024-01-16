#!/usr/bin/env bash

lock() {
	i3lock -i ~/dotfiles/wallpapers/wallpaperblur.png
}

case "$1" in 
	lock)
			lock
			;;
	logout)
			i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -B 'Yes, exit i3' 'i3-msg exit'
			;;
  suspend)
			lock && systemctl suspend
			;;
	reboot)
			i3-nagbar -t warning -m 'You pressed the Reboot. Do you really want to exit i3 and reboot? This will end your X session.' -B 'Yes, reboot' 'systemctl reboot'
			;;
	shutdown)
			i3-nagbar -t warning -m 'You pressed the Shut Down. Do you really want to exit i3 and shutdown? This will end your X session.' -B 'Yes, shutdown' 'systemctl poweroff'
			;;
	*)
			echo "Usage: $0 [OPTION]

OPTION: {lock|logout|suspend|shutdown}"
			exit 2
esac

exit 0
	
