#!/bin/bash

. /etc/os-release

if [[ "$ID" != "ubuntu" ]];
then
    echo "Sorry, I am still not sure if this will work on an OS other than Ubuntu"
    exit 1
fi

prompt() {
    read -p "$1 (Y)es (N)o (Q)uit: " -r input
    case "$input" in
        y|Y) $2 ;;
        q|Q) exit 0
    esac
}

multiselect() {
	  # I copy this function from a handsome guy on unix.stackexchange, I want to express my deepest gratitude to him
	  # Credit: https://unix.stackexchange.com/questions/146570/arrow-key-enter-menu/673436#673436 
    # little helpers for terminal print control and key input
    ESC=$( printf "\033")
    cursor_blink_on()   { printf "$ESC[?25h"; }
    cursor_blink_off()  { printf "$ESC[?25l"; }
    cursor_to()         { printf "$ESC[$1;${2:-1}H"; }
    print_inactive()    { printf "$2   $1 "; }
    print_active()      { printf "$2  $ESC[7m $1 $ESC[27m"; }
    get_cursor_row()    { IFS=';' read -sdR -p $'\E[6n' ROW COL; echo ${ROW#*[}; }

    local return_value=$1
    local -n options=$2
    local -n defaults=$3

    local selected=()
    for ((i=0; i<${#options[@]}; i++)); do
        if [[ ${defaults[i]} = "true" ]]; then
            selected+=("true")
        else
            selected+=("false")
        fi
        printf "\n"
    done

    # determine current screen position for overwriting the options
    local lastrow=`get_cursor_row`
    local startrow=$(($lastrow - ${#options[@]}))

    # ensure cursor and input echoing back on upon a ctrl+c during read -s
    trap "cursor_blink_on; stty echo; printf '\n'; exit" 2
    cursor_blink_off

    key_input() {
        local key
        IFS= read -rsn1 key 2>/dev/null >&2
        if [[ $key = ""      ]]; then echo enter; fi;
        if [[ $key = $'\x20' ]]; then echo space; fi;
        if [[ $key = "k" ]]; then echo up; fi;
        if [[ $key = "j" ]]; then echo down; fi;
        if [[ $key = $'\x1b' ]]; then
            read -rsn2 key
            if [[ $key = [A || $key = k ]]; then echo up;    fi;
            if [[ $key = [B || $key = j ]]; then echo down;  fi;
        fi 
    }

    toggle_option() {
        local option=$1
        if [[ ${selected[option]} == true ]]; then
            selected[option]=false
        else
            selected[option]=true
        fi
    }

    print_options() {
        # print options by overwriting the last lines
        local idx=0
        for option in "${options[@]}"; do
            local prefix="[ ]"
            if [[ ${selected[idx]} == true ]]; then
              prefix="[\e[38;5;46m✔\e[0m]"
            fi

            cursor_to $(($startrow + $idx))
            if [ $idx -eq $1 ]; then
                print_active "$option" "$prefix"
            else
                print_inactive "$option" "$prefix"
            fi
            ((idx++))
        done
    }

    local active=0
    while true; do
        print_options $active

        # user key control
        case `key_input` in
            space)  toggle_option $active;;
            enter)  print_options -1; break;;
            up)     ((active--));
                    if [ $active -lt 0 ]; then active=$((${#options[@]} - 1)); fi;;
            down)   ((active++));
                    if [ $active -ge ${#options[@]} ]; then active=0; fi;;
        esac
    done

    # cursor position back to normal
    cursor_to $lastrow
    printf "\n"
    cursor_blink_on

    eval $return_value='("${selected[@]}")'
}

install_kitty_terminal() {
    echo "-------->> INSTALL Kitty <<----------"
    curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
}


install_nvim() {
    echo "-------->> INSTALL Neovim <<----------"
    curl -s https://api.github.com/repos/neovim/neovim/releases/latest \
        | grep "browser_download_url.*nvim.appimage\"" \
        | cut -d : -f 2,3 \
        | tr -d \" \
        | xargs wget -q
    chmod +x nvim.appimage
    mv nvim.appimage $HOME/.local/bin/nvim
    echo "Install Successfully"
};

install_helix() {
    echo "-------->> INSTALL Helix <<----------"
    curl -s https://api.github.com/repos/helix-editor/helix/releases/latest \
        | grep "browser_download_url.*AppImage\"" \
        | cut -d : -f 2,3 \
        | tr -d \" \
        | xargs wget -q
    find -name 'helix*.AppImage' -exec mv {} ./hx \;
    chmod +x ./hx
    mv ./hx $HOME/.local/bin
    echo "Install Successfully"
}

install_zellij() {
    echo "-------->> INSTALL Zellij <<----------"
    curl -s https://api.github.com/repos/zellij-org/zellij/releases/latest \
        | grep "browser_download_url.*zellij-x86_64-unknown-linux-musl.tar.gz\"" \
        | cut -d : -f 2,3 \
        | tr -d \" \
        | xargs wget -q
    tar -xvf zellij-x86_64-unknown-linux-musl.tar.gz
    rm -f zellij-x86_64-unknown-linux-musl.tar.gz
    chmod +x zellij
    mv zellij $HOME/.local/bin
    echo "Install Successfully"
}

install_hugo() {
    echo "-------->> INSTALL Hugo <<----------"
    curl -s https://api.github.com/repos/gohugoio/hugo/releases/latest \
        | grep "browser_download_url.*hugo_extended_.*Linux-64bit.tar.gz" \
        | cut -d : -f 2,3 \
        | tr -d \" \
        | xargs wget -q
    find -name 'hugo_extended_*.tar.gz' -exec mv {} ./hugo.tar.gz \;
    tar -xvf hugo.tar.gz hugo
    chmod +x hugo
    mv hugo $HOME/.local/bin
    rm -f hugo.tar.gz
    echo "Install Successfully"
}

install_lazysql() {
    echo "-------->> INSTALL Lazysql <<----------"
    curl -s https://api.github.com/repos/jorgerojas26/lazysql/releases/latest \
        | grep "browser_download_url.*lazysql_Linux_x86_64.tar.gz" \
        | cut -d : -f 2,3 \
        | tr -d \" \
        | xargs wget -q
    tar -xvf lazysql_Linux_x86_64.tar.gz lazysql
    chmod +x lazysql
    mv lazysql $HOME/.local/bin
    rm -f lazysql_Linux_x86_64.tar.gz
    echo "Install Successfully"
}

install_curl() {
    sudo apt install curl
}

install_wget() {
    sudo apt install wget
}

check_curl_exist() {	
		if ! command -v curl &> /dev/null
		then
				echo "It seem that you not have curl, try to install curl"
				exit 1
		fi
}

check_wget_exist() {
		if ! command -v wget &> /dev/null
		then
				echo "It seem that you not have wget, try to install wget"
				exit 1
		fi
}

check_tar_exist() {
		if ! command -v tar &> /dev/null
		then
				echo "It seem that you not have tar, try to install tar"
				exit 1
		fi
}

check_time() {
	currenttime=$(date +%H:%M)
  if [[ "$currenttime" > "06:00" ]] || [[ "$currenttime" < "12:00" ]];
	then
		echo "morning"
	elif [[ "$currenttime" > "11:59" ]] || [[ "$currenttime" < "18:00" ]];
	then
		echo "afternoon"
	else
		echo "evening"
	fi
}

start_install() {
	idx=0
	for option in "${my_options[@]}"; do
			echo -e "$option\t=> ${result[idx]}"
			((idx++))
	done
}

print_banner() {
	echo
	echo "██╗    ██╗ █████╗ ██╗████████╗███████╗██████╗"
	echo "██║    ██║██╔══██╗██║╚══██╔══╝██╔════╝██╔══██╗"
	echo "██║ █╗ ██║███████║██║   ██║   █████╗  ██████╔╝"
	echo "██║███╗██║██╔══██║██║   ██║   ██╔══╝  ██╔══██╗"
	echo "╚███╔███╔╝██║  ██║██║   ██║   ███████╗██║  ██║"
	echo " ╚══╝╚══╝ ╚═╝  ╚═╝╚═╝   ╚═╝   ╚══════╝╚═╝  ╚═╝"
	echo
	echo "Good $(check_time) Sir! Please feel free to take a look at our menu"
	echo "and let me know whenever you're ready to place your order."
	echo 
	echo "╭─ Hint ─────────────────────────╮"
	echo "│ Using j or ↓ to move down      │"
	echo "│ Using k or ↑ to move up        │"
	echo "│ Press <Space> to toggle select │"
	echo "│ Press <Enter> to start install │"
	echo "│ Press <Ctrl-c> to cancel       │"
	echo "╰────────────────────────────────╯" 
	echo 
	echo "────────────── MENU ──────────────"
}

main() {

  print_banner

  my_options=(
		"Kitty Terminal 😺"
		"Neovim  "
		"Helix 󰚄 "
		"Zellij 󰋙 "
		"Hugo"
		"Lazysql"
	)
	preselection=(
		"false"
		"false"
		"false"
		"false"
		"false"
		"false"
	)

	multiselect result my_options preselection

	# start_install result my_options

	idx=0
	for option in "${my_options[@]}"; do
			echo -e "$option\t=> ${result[idx]}"
			((idx++))
	done

}

main "$@"
