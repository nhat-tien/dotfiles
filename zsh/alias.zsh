alias bmv="~/DEV/BanhmiVim/banhmivim/bin/banhmivim"
alias c="clear"
alias cf=". ${DOTFILES}/scripts/cdf.sh"
alias dev="cf ~/DEV"
alias lg="lazygit"

# Notes Vaults
alias nt="cf ~/Documents/Notes"
alias misc="bmv ${MYNOTES}/misc"
alias life="bmv ${MYNOTES}/my-life"
alias oo="bmv ${MYNOTES}/noteVault"
alias on="${DOTFILES}/scripts/new-notes"

alias dot="bmv ${DOTFILES}"
alias nv="bmv ~/DEV/BanhmiVim/banhmivim/config/banhmivim"
alias z="zellij --layout ${DOTFILES}/zellij/layouts/default.kdl"
alias zw="zellij -l welcome"
alias blog="nvim ~/DEV/Hugo/blog"
# alias v="nvim"
alias v="bmv"
alias dl="cd ~/Downloads/"
alias cdbin="cd /usr/local/bin"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# alias Xampp
alias apachestop="sudo /etc/init.d/apache2 stop"

alias dk="docker"
alias dkcp="docker compose"

# Gio trash
alias trash="gio trash"
alias opentrash="cd ~/.local/share/Trash/files/ && y"
alias sutrash="sudo gio trash"

# screenfetch
# alias neofetch="screenfetch -c '04,15' -a '${HOME}/dotfiles/asciiart/asciiart.sh' -d '-uptime,pkgs,wmtheme' "
# alias neofetch="screenfetch -c '04,15' -a '${HOME}/dotfiles/asciiart/asciiart.sh' -d '-wmtheme' "
# alias neofetch="screenfetch -c '04,15' -a '${DOTFILES}/asciiart/asciiart.sh' "

#clock
alias clock="tty-clock -c -f \"\" -C 3 "

#git tree
alias gittree="git log --oneline --decorate --graph --all"

alias sail='sh $([ -f sail ] && echo sail || echo vendor/bin/sail)'
alias run="dmenu_path | fzf | xargs -r -I {} sh -c '{} > /dev/null 2>&1 &'"
alias icat="kitty icat"

alias theme:light="gsettings set org.gnome.desktop.interface color-scheme prefer-light"
alias theme:dark="gsettings set org.gnome.desktop.interface color-scheme prefer-dark"

alias dj="uv run manage.py"

alias nixbuild="sudo nixos-rebuild switch --flake ~/dotfiles#laptop"
