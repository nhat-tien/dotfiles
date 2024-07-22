alias zshrc="nvim ~/.zshrc"
alias cls="clear"
alias dev="cd ~/DEV"
alias notes="nvim ~/NotesVaults/notes"
alias jn="nvim ~/NotesVaults/journal"
alias vault="nvim ~/NotesVaults/mainVault"
alias dotfiles="nvim ~/dotfiles"
alias nvcf="nvim ~/dotfiles/nvim"
alias z="zellij --layout ~/dotfiles/zellij/layouts/default.kdl"
alias site="nvim ~/DEV/Hugo/my-blog"
alias lg="lazygit"
alias v="nvim"
alias dl="cd ~/Downloads/"
alias lbin="cd /usr/local/bin"
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

# Gio trash
alias trash="gio trash"
alias sutrash="sudo gio trash"

#screenfetch
# alias neofetch="screenfetch -c '04,15' -a '${HOME}/dotfiles/asciiart/asciiart.sh' -d '-uptime,pkgs,wmtheme' "
# alias neofetch="screenfetch -c '04,15' -a '${HOME}/dotfiles/asciiart/asciiart.sh' -d '-wmtheme' "
alias neofetch="screenfetch -c '04,15' -a '${HOME}/dotfiles/asciiart/asciiart.sh' "

#clock
alias clock="tty-clock -c -f \"\" -C 3 "

#git tree
alias gittree="git log --oneline --decorate --graph --all"

alias sail='sh $([ -f sail ] && echo sail || echo vendor/bin/sail)'

#python virtual environment
alias pyenvinit='python3 -m venv ./env'
alias pyactivate='source ./env/bin/activate'

# workspace-setup
# alias ws="$HOME/dotfiles/scripts/workspace-setup.sh"
