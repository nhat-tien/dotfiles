alias hxconfig="hx ~/.config/helix"
alias zshrc="hx ~/.zshrc"
alias cls="clear"
alias dev="cd ~/DEV"
alias dotfiles="hx ~/dotfiles"

# alias Xampp
alias apachestop="sudo /etc/init.d/apache2 stop"
alias xampp="sudo /opt/lampp/manager-linux-x64.run"
alias xamppstatus="sudo /opt/lampp/lampp status"
alias xamppstart="sudo /opt/lampp/lampp start"
alias xamppstop="sudo /opt/lampp/lampp stop"

# alias Mongodb
alias mongostart="sudo systemctl start mongod"
alias mongostatus="sudo systemctl status mongod"
alias mongostop="sudo systemctl stop mongod"

# alias Docker
alias dockerstart="sudo systemctl start docker"
alias dockerstatus="sudo systemctl status docker"
alias dockerstop="sudo systemctl stop docker.socket"

#screenfetch
alias neofetch="screenfetch -c '04,15' -a '${HOME}/dotfiles/asciiart/asciiart.sh' -d '-uptime,pkgs,wmtheme' "
# alias neofetch="screenfetch -c '04,15' -a '${HOME}/dotfiles/asciiart/asciiart.sh' -d '-wmtheme' "

#clock
alias clock="tty-clock -c -f "" -C 3 "

#git tree
alias gittree="git log --oneline --decorate --graph --all"

#notes
alias journal="hx ~/ObsidianVaults/notes"

export GOPATH=$HOME/go

path+=('~/.npm-packages/bin')
export PATH
