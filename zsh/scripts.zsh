
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

function on() {
    if [ -z "$1" ]; then
      echo "Error: A file name must be set, e.g. on \"the wonderful thing about tiggers\"."
      exit 1
    fi

    file_name=$(echo "$1" | tr ' ' '-')
    formatted_file_name=$(date "+%Y-%m-%d")_${file_name}.md
    cd "${HOME}/Documents/Notes/mainVault/"
    touch "inbox/${formatted_file_name}"
    nvim "inbox/${formatted_file_name}"
}

