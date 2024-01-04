#!/usr/bin/env zsh

DOTFILES=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

rm -rf "${HOME}/.config/kitty"
ln -s "${DOTFILES}/kitty" "${HOME}/.config/kitty"  

rm -rf "${HOME}/.config/helix"
ln -s "${DOTFILES}/helix" "${HOME}/.config/helix"  

echo " source "${HOME}/dotfiles/zsh/main.zsh"" >> "${HOME}/.zshrc"

echo Install Successful
