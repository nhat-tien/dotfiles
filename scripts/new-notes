#!/bin/bash

if [ -z "$1" ]; then
    echo "Error: A file name must be set, e.g. on \"the wonderful thing about tiggers\"."
    exit 1
fi

parameter=$1
file_name=$(echo "$1" | tr ' ' '-')
now=$(date "+%Y-%m-%d")
formatted_file_name=${now}-${file_name}.md

cd "${HOME}/Documents/Notes/mainVault/"

touch "inbox/${formatted_file_name}"

cat << EOF > ./inbox/${formatted_file_name}
---
date: "${now}"
tags:
  - 
hub: "" 
---

## ${parameter}
EOF

nvim "inbox/${formatted_file_name}"
