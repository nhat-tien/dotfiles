# ------ Export, Env Variable ----
source $HOME/dotfiles/zsh/export.zsh

# ----- Alias ------
source $HOME/dotfiles/zsh/alias.zsh

# ------ HELPFUL SCRIPTS -----
source $HOME/dotfiles/zsh/scripts.zsh

# ------ Export Env Key -----
source $HOME/env_key.zsh

# ------ Starship.rs promt ------
if command -v starship  &> /dev/null
then
  eval "$(starship init zsh)" 
fi

source $HOME/dotfiles/scripts/print_image.sh

# ------ Ghostty integration ------
# if [[ -n $GHOSTTY_RESOURCES_DIR ]]; then
#   source "$GHOSTTY_RESOURCES_DIR"/zsh/ghostty-integration
# fi
