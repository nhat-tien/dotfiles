#!/bin/bash

zellij action new-pane --direction right 

zellij action new-pane --direction down

zellij action resize increase left 
zellij action resize increase left 
zellij action resize increase left 
zellij action resize increase left 
zellij action resize increase left 

zellij action move-focus up 

zellij action resize increase down 
zellij action resize increase down 
zellij action resize increase down 
zellij action resize increase down 
zellij action resize increase down 

zellij action write-chars "hx ."
zellij action write 13
zellij action write 27

zellij action move-focus left

zellij action write-chars "nnn" 
zellij action write 13



