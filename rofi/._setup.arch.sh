#!/usr/bin/env bash

source ${DOTFILES}/setup/common.sh
source ${DOTFILES}/setup/symlinks.sh

install() {
    sudo pacman -S --noconfirm rofi
}

is_installed() {
    check_if_installed rofi
}

configure() {
    return 77
}

is_configured() {
    return 77
}
