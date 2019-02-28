#!/usr/bin/env bash

source ${DOTFILES}/setup/common.sh

install() {
    sudo pacman -S --noconfirm fzf
}

configure() {
    return 77
}

is_installed() {
   check_if_installed fzf
}

is_configured() {
    return 77
}
