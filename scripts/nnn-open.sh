#!/bin/bash

fpath="$1"

zellij action move-focus right 
zellij action write 27
zellij action write-chars ":o ${fpath}" 
zellij action write 13

