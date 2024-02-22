alias zshrc="hx ~/.zshrc"
alias cls="clear"
alias dev="cd ~/DEV"
alias dotfiles="hx ~/dotfiles"
alias journal="nvim ~/ObsidianVaults/journal" 
alias notes="nvim ~/ObsidianVaults/notes"
alias eng="nvim ~/ObsidianVaults/english-practice"
alias vault="nvim ~/ObsidianVaults/mainVault"
alias zet="nvim ~/ObsidianVaults/zettel"
alias vimdot="nvim ~/dotfiles"

# alias Xampp
alias apachestop="sudo /etc/init.d/apache2 stop"

# alias Mongodb
alias mongostart="sudo systemctl start mongod"
alias mongostatus="sudo systemctl status mongod"
alias mongostop="sudo systemctl stop mongod"

# alias Nginx
alias mysqlstart="sudo systemctl start nginx"
alias mysqlstatus="sudo systemctl status nginx"
alias mysqlstop="sudo systemctl stop nginx"
 
# alias MySql 
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
alias neofetch="screenfetch -c '04,15' -a '${HOME}/dotfiles/asciiart/asciiart.sh' "

#clock
alias clock="tty-clock -c -f \"\" -C 3 "

#git tree
alias gittree="git log --oneline --decorate --graph --all"

#icat
alias icat="kitty +kitten icat"

#workspace-setup
alias ws="$HOME/dotfiles/scripts/workspace-setup.sh"

export GOPATH=$HOME/go
export EDITOR=nvim

# NNN
export NNN_OPENER=$HOME/dotfiles/scripts/nnn-open.sh
export NNN_TRASH=2

path+=('/home/nhattien/.npm-packages/bin')
path+=('/opt/apache-maven-3.6.3/bin')
export PATH
