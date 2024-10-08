
function mkdircd()
{
  mkdir -p "$@" && eval "cd \"\$$#\""; 
}

function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

function restore() {
  gio trash --restore "trash:/$1"
}

function s() {  
  sudo systemctl "$2" "$1" 
}
