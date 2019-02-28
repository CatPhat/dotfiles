#!/usr/bin/env bash

source ${DOTFILES}/setup/common.sh

install() {
    sudo pacman -S --noconfirm \
        noto-fonts \
        noto-fonts-emoji

    trizen -S --noconfirm \
        nerd-fonts-complete

    fc-cache -fv
}

is_installed() {
    local nerd_is_installed=false
    fc-list | grep -q "nerd-fonts-complete" && nerd_is_installed=true

    local noto_is_installed=false
    fc-list | grep -q "noto" && noto_is_installed=true

    if [[ ${nerd_is_installed} == true && ${noto_is_installed} == true ]]; then
        return 0
    else
        return 1
    fi

}

configure() {
    return 77
}

is_configured() {
    return 77
}
