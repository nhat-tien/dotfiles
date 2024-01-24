alias hxconfig="hx ~/.config/helix"
alias zshrc="hx ~/.zshrc"
alias cls="clear"
alias dev="cd ~/DEV"
alias dotfiles="hx ~/dotfiles"

# alias Xampp
alias apachestop="sudo /etc/init.d/apache2 stop"

# alias Mongodb
alias mongostart="sudo systemctl start mongod"
alias mongostatus="sudo systemctl status mongod"
alias mongostop="sudo systemctl stop mongod"

#mysql 
alias mysqlstart="sudo systemctl start mysql.service"
alias mysqlstatus="sudo systemctl status mysql.service"
alias mysqlstop="sudo systemctl stop mysql.service"

# alias Docker
alias dockerstart="sudo systemctl start docker"
alias dockerstatus="sudo systemctl status docker"
alias dockerstop="sudo systemctl stop docker.socket"

# Gio trash
alias trash="gio trash"

#screenfetch
# alias neofetch="screenfetch -c '04,15' -a '${HOME}/dotfiles/asciiart/asciiart.sh' -d '-uptime,pkgs,wmtheme' "
# alias neofetch="screenfetch -c '04,15' -a '${HOME}/dotfiles/asciiart/asciiart.sh' -d '-wmtheme' "
alias neofetch="screenfetch -c '04,15' -a '${HOME}/dotfiles/asciiart/asciiart.sh'"

#clock
alias clock="tty-clock -c -f \"\" -C 3 "

#git tree
alias gittree="git log --oneline --decorate --graph --all"

alias journal="hx ~/ObsidianVaults/journal" 

#notes
alias notes="hx ~/ObsidianVaults/notes"

#english
alias eng="hx ~/ObsidianVaults/english-practice"

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=6'

export GOPATH=$HOME/go

path+=('~/.npm-packages/bin')
export PATH
