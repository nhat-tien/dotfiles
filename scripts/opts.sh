#!/usr/bin/env bash


function main() {
    if [[ "$#" == 0 ]]; then
        exit 1
    fi

    local key="$1"

    shift

    while [[ "$#" -gt 0 ]]; do

        if [[ "$1" == "$key" ]]; then
            shift
            echo "$1"
            exit
        else
            shift
        fi

    done
}

main "$@"
