#!/usr/bin/env bash

source ${DOTFILES}/setup/common.sh

install() {
    sudo pacman -S --noconfirm docker
}

configure() {
    return 77
}

is_installed() {
   check_if_installed docker
}

is_configured() {
    return 77
}
