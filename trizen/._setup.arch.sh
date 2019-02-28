#!/usr/bin/env bash

source ${DOTFILES}/setup/common.sh

install() {
    git clone https://aur.archlinux.org/trizen.git  /tmp/trizen \
    && cd /tmp/trizen \
    && makepkg -si --noconfirm
}

configure() {
    return 77
}

is_installed() {
   check_if_installed trizen
}

is_configured() {
    return 77
}
