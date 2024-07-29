#!/bin/bash

DOTFILES=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

packages=(
	"kitty"
	"helix"
	"zellij"
	"polybar"
	"i3"
	"picom"
	"rofi"
	"wezterm"
	"nvim"
)

for package in "${packages[@]}"; do
	rm -rf "${HOME}/.config/${package}"
	ln -s "${DOTFILES}/${package}" "${HOME}/.config/$package"  
done

echo " source "${HOME}/dotfiles/zsh/main.zsh"" >> "${HOME}/.zshrc"

echo Install Successful
