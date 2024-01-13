#!/usr/bin/env bash

killall -q picom

picom --config ~/.config/picom/picom.conf -b

