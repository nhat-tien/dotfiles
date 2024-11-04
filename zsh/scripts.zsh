
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
    python3 -m venv ./.env
  fi
  if [[ "$1" == "dev" ]]; then
    source ./.env/bin/activate
  fi
  if [[ "$1" == "stop" ]]; then
    deactivate
  fi
}
