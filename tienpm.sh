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
  if [[ "$currenttime" > "06:00" ]] && [[ "$currenttime" < "12:00" ]];
  then
    echo "morning"
  elif [[ "$currenttime" > "11:59" ]] && [[ "$currenttime" < "18:00" ]];
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
  echo "     ██╗    ██╗ █████╗ ██╗████████╗███████╗██████╗"
  echo "     ██║    ██║██╔══██╗██║╚══██╔══╝██╔════╝██╔══██╗"
  echo "     ██║ █╗ ██║███████║██║   ██║   █████╗  ██████╔╝"
  echo "     ██║███╗██║██╔══██║██║   ██║   ██╔══╝  ██╔══██╗"
  echo "     ╚███╔███╔╝██║  ██║██║   ██║   ███████╗██║  ██║"
  echo "      ╚══╝╚══╝ ╚═╝  ╚═╝╚═╝   ╚═╝   ╚══════╝╚═╝  ╚═╝"
  echo
  echo -e " \e[3mGood $(check_time) Sir! Please feel free to take a look at our menu\e[0m"
  echo -e " \e[3mand let me know whenever you're ready to place your order.\e[0m"
  echo 
  echo " ╭─ Hint ─────────────────────────╮"
  echo " │ Using j or ↓ to move down      │"
  echo " │ Using k or ↑ to move up        │"
  echo " │ Press <Space> to toggle select │"
  echo " │ Press <Enter> to start install │"
  echo " │ Press <Ctrl-c> to cancel       │"
  echo " ╰────────────────────────────────╯" 
  echo 
  echo " ────────────── MENU ──────────────"
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
    # multiselect result my_options preselection

  # start_install result my_options
  
  # idx=0
  # for option in "${my_options[@]}"; do
  #     echo -e "$option\t=> ${result[idx]}"
  #     ((idx++))
  # done

}

main "$@"
