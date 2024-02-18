#!/bin/bash

zellij action new-pane --direction right 

zellij action new-pane --direction down

for i in {0..4}
do 
zellij action resize increase left 
done 

zellij action move-focus up 

for i in {0..4}
do 
zellij action resize increase down 
done 

zellij action write-chars "hx ."
zellij action write 13
zellij action write 27

zellij action move-focus left

zellij action write-chars "nnn" 
zellij action write 13



