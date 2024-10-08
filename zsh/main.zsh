# ------ Export, Env Variable ----
source $HOME/dotfiles/zsh/export.zsh

# ----- Alias ------
source $HOME/dotfiles/zsh/alias.zsh

# ------ HELPFUL SCRIPTS -----
source $HOME/dotfiles/zsh/scripts.zsh

# ------ Starship.rs promt ------
if command -v starship  &> /dev/null
then
  eval "$(starship init zsh)" 
fi
