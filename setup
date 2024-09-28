#!/bin/bash

DOTFILES=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

packages=(
    "kitty"
    "helix"
    "zellij"
    "polybar"
    "i3"
    "picom"
    "rofi"
    "wezterm"
    "nvim"
    "eww"
    "yazi"
    "zsh"
)

flag_force=0

print_list_of_config() {
    echo "--- List of config ---"
    for package in "${packages[@]}"; do
        echo "$package"
    done
}

print_help() {
    echo "This is a small bash script to setup dotfiles Ubuntu"
    echo "COMMAND:"
    echo ""
    echo "setup.sh --setup <package-name>"
    echo ""
    echo "OPTIONS:"
    echo ""
    echo "-h     --help        show help"
    echo "-s     --setup       setup package"
    echo "-l     --list        show list of available config"
    echo "-f     --force       replace if config folder exist"
    echo "-a     --all         setup all available config"
}

setup_zsh() {
    echo " source "${DOTFILES}/zsh/main.zsh"" >> "${HOME}/.zshrc"
}

setup() {
    if [[ $1 == "zsh" ]]; then
        setup_zsh
    else
        if [[ -d "$HOME/.config/$1" ]]; then
            echo "You already have $1 in ~/.config"
            echo "Do you want to replace it ?"
            read -p "$1 (Y)es (N)o: " -r input
            case "$input" in
                y|Y)
                    rm -rf "${HOME}/.config/$1"
                    ;;
                *)
                    exit 0
                    ;;
            esac
        fi
        ln -s "${DOTFILES}/$1" "${HOME}/.config/$1"
    fi
}

setup_force() {
    if [[ $1 == "zsh" ]]; then
        setup_zsh
    else
        rm -rf "${HOME}/.config/$1"
        ln -s "${DOTFILES}/$1" "${HOME}/.config/$1"
    fi
}

setup_all() {
    if [[ $1 == 1 ]]; then
        for package in "${packages[@]}"; do
            setup_force $package
        done
    else
        for package in "${packages[@]}"; do
            setup $package
        done
    fi

    echo Setup Successful
}


main() {
    while [[ "$#" -gt 0 ]]; do
        case "$1" in
            -h|--help)
                print_help
                print_list_of_config
                exit 0
                ;;
            -l|--list)
                print_list_of_config
                exit 0
                ;;
            -a|--all)
                if [[ $flag_force == 1 ]]; then
                    setup_all $flag_force
                else
                    setup_all
                fi
                exit 0
                ;;
            -f|--force)
                flag_force=1
                shift
                ;;
            -s|--setup)
                shift
                if [[ $# == 0 ]]; then
                    echo "Please give config name"
                fi
                while [[ "$#" -gt 0 ]]; do
                    value="\<${1}\>"
                    if [[ ${packages[@]} =~ $value ]]
                    then
                        if [[ $flag_force == 1 ]]; then
                            setup_force $1
                        else
                            setup $1
                        fi
                    else
                        echo "name not found"
                        exit 1
                    fi
                    shift
                done
                exit 0
                ;;
            *)
                echo "Command not found"
                print_help
                print_list_of_config
                exit 0
                ;;
        esac
    done
}

main "$@"
