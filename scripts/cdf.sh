#!/usr/bin/env bash

ignore_dirs=(
  # .git
  # .cache
  # .venv
  # .svelte-kit
  node_modules
  target
  dist
  build
  ".*"
)

prune_expr=""

for dir in "${ignore_dirs[@]}"; do
  prune_expr+=" -path \"*/${dir}\" -o"
done

prune_expr=$(echo "${prune_expr}" | sed "s/ -o$//")

dir=$(eval "find "${1:-.}" \( "${prune_expr}" \) -prune -o -type d -print" 2>/dev/null | fzf )

if [[ -n "$dir" ]]; then
  cd "$dir" || echo "Failed to cd into $dir"
fi
