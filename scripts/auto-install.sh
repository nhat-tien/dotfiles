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

install_curl() {
  sudo apt install curl   
}

install_wget() {
	sudo apt install wget
}


if ! command -v curl &> /dev/null
then
	echo "It seem that you not have curl, try to install curl"
	exit 1
fi 

if ! command -v wget &> /dev/null
then
	echo "It seem that you not have wget, try to install wget" 
	exit 1
fi 

prompt "Would you like to install Kitty Terminal 😺?" install_kitty_terminal
prompt "Would you like to install Neovim  ?" install_nvim
prompt "Would you like to install Helix 󰚄 ?" install_helix
prompt "Would you like to install Zellij 󰋙 ?" install_zellij
