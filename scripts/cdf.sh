#!/usr/bin/env bash

ignore_dirs=(
  node_modules
  target
  dist
  build
)

prune_expr=""

# Ignore all dot folder, but exclude the folder in dot_exclude
if true; then # Change true to false to disable

  dot_exclude=(
    .local
    .config
  )

  prune_expr+=" -path \"*/.*\""

  for dir in "${dot_exclude[@]}"; do
    prune_expr+=" ! -path \"*/${dir}\" ! -path \"*/${dir}/*\""
  done

  prune_expr+=" -o"
fi
# ---------------------------

for dir in "${ignore_dirs[@]}"; do
  prune_expr+=" -path \"*/${dir}\" -o"
done

prune_expr=$(echo "${prune_expr}" | sed "s/ -o$//")


dir=$(eval "find \"${1:-.}\" \( $prune_expr \) -prune -o -type d -print" 2>/dev/null | fzf --preview="ls {}")

if [[ -n "$dir" ]]; then
  cd "$dir" || echo "Failed to cd into $dir"
fi
