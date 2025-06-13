#!/usr/bin/env bash

dir=$(find "${1:-.}" \( -name .git \
  -o -name node_modules \
  -o -name target \
  -o -name dist \
  -o -name build \
  -o -name .cache \
  -o -name .venv \) -prune -o -type d -print 2>/dev/null | fzf )
if [[ -n "$dir" ]]; then
  cd "$dir" || echo "Failed to cd into $dir"
fi
