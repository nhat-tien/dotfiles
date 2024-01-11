#!/usr/bin/env zsh

DOTFILES=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

rm -rf "${HOME}/.config/kitty"
ln -s "${DOTFILES}/kitty" "${HOME}/.config/kitty"  

rm -rf "${HOME}/.config/helix"
ln -s "${DOTFILES}/helix" "${HOME}/.config/helix"  

rm -rf "${HOME}/.config/zellij"
ln -s "${DOTFILES}/zellij" "${HOME}/.config/zellij" 

rm -rf "${HOME}/.config/polybar"
ln -s "${DOTFILES}/polybar" "${HOME}/.config/polybar"

rm -rf "${HOME}/.config/i3"
ln -s "${DOTFILES}/i3" "${HOME}/.config/i3"     

echo " source "${HOME}/dotfiles/zsh/main.zsh"" >> "${HOME}/.zshrc"

echo Install Successful
