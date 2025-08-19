
mkdircd()
{
  mkdir -p "$@" && eval "cd \"\$$#\""; 
}

yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

restore() {
  gio trash --restore "trash:/$1"
}

s() {  
  sudo systemctl "$2" "$1" 
}

pyenv() {
  if [[ "$1" == "init" ]]; then
    python3 -m venv ./.venv
  fi
  if [[ "$1" == "on" ]]; then
    source ./.venv/bin/activate
  fi
  if [[ "$1" == "off" ]]; then
    deactivate
  fi
}

cw() {
  file_path="$(yazi --chooser-file=/dev/stdout "$DOTFILES/wallpapers" | while read -r; do printf "%q" "$REPLY"; done)"
  if [[ "$file_path" != "" ]]; then 
    feh --bg-fill "$file_path"
  fi
}

dkcmp() {
  case "$1" in
    "up")
        docker compose up -d
      ;;
    "down")
        docker compose down 
      ;;
    *)
      echo "Command not found"
      ;;
  esac
}

