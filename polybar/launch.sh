#!/usr/bin/env bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use 
# polybar-msg cmd quit
# Otherwise you can use the nuclear option:
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

echo "---" | tee -a /tmp/polybar1.log 
polybar bar1 2>&1 --config="~/.config/polybar/config.ini" | tee -a /tmp/polybar1.log  & disown 

echo "Bars launched..."
