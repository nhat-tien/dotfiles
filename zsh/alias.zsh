alias zshrc="nvim ~/.zshrc"
alias c="clear"
alias cf=". ${DOTFILES}/scripts/cdf.sh"
# alias dev="yy ~/DEV"
alias dev="cf ~/DEV"
alias td="nvim ${MYNOTES}/plan"
# alias jn="nvim ${MYNOTES}/journal"
alias nt="cf ~/Documents/Notes"
alias oo="nvim ${MYNOTES}/noteVault"
# alias oi="cd ${MYNOTES}/mainVault/inbox && nvim *"
alias on="${DOTFILES}/scripts/new-notes"
alias dot="nvim ${DOTFILES}"
alias nv="nvim ${DOTFILES}/nvim"
alias z="zellij --layout ${DOTFILES}/zellij/layouts/default.kdl"
alias zw="zellij -l welcome"
alias blog="nvim ~/DEV/Hugo/blog"
alias lg="lazygit"
alias v="nvim"
alias dl="cd ~/Downloads/"
alias cdbin="cd /usr/local/bin"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# alias Xampp
alias apachestop="sudo /etc/init.d/apache2 stop"

# alias Mongodb
alias mongostart="sudo systemctl start mongod"
alias mongostatus="sudo systemctl status mongod"
alias mongostop="sudo systemctl stop mongod"

# alias Nginx
alias nginxstart="sudo systemctl start nginx"
alias nginxrestart="sudo systemctl restart nginx"
alias nginxstatus="sudo systemctl status nginx"
alias nginxstop="sudo systemctl stop nginx"
 
# alias MySql 
alias mysqlstart="sudo systemctl start mysql.service"
alias mysqlstatus="sudo systemctl status mysql.service"
alias mysqlstop="sudo systemctl stop mysql.service"

# alias Docker
alias dockerstart="sudo systemctl start docker"
alias dockerstatus="sudo systemctl status docker"
alias dockerstop="sudo systemctl stop docker.socket"
alias dk="docker"
alias dkcp="docker compose"

# Gio trash
alias trash="gio trash"
alias opentrash="cd ~/.local/share/Trash/files/ && y"
# alias emptytrash="rm -rf ~/.local/share/Trash/files/*"
alias sutrash="sudo gio trash"

# screenfetch
# alias neofetch="screenfetch -c '04,15' -a '${HOME}/dotfiles/asciiart/asciiart.sh' -d '-uptime,pkgs,wmtheme' "
# alias neofetch="screenfetch -c '04,15' -a '${HOME}/dotfiles/asciiart/asciiart.sh' -d '-wmtheme' "
alias neofetch="screenfetch -c '04,15' -a '${DOTFILES}/asciiart/asciiart.sh' "

#clock
alias clock="tty-clock -c -f \"\" -C 3 "

#git tree
alias gittree="git log --oneline --decorate --graph --all"

alias sail='sh $([ -f sail ] && echo sail || echo vendor/bin/sail)'
alias run="dmenu_path | fzf | xargs -r -I {} sh -c '{} > /dev/null 2>&1 &'"
alias icat="kitty icat"

alias theme:light="gsettings set org.gnome.desktop.interface color-scheme prefer-light"
alias theme:dark="gsettings set org.gnome.desktop.interface color-scheme prefer-dark"

