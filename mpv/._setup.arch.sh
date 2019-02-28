#!/usr/bin/env bash

source ${DOTFILES}/setup/common.sh
source ${DOTFILES}/setup/symlinks.sh

install() {
    local proceed=false
    if [[ $(command -v ffmpeg) != "" ]]; then
        proceed=true
    else
        info "Are you sure you want to install mpv without installing/compiling ffmpeg first? (y/n)"
        select yn in "Yes" "No"; do
            case $yn in
                Yes ) info "installing mpv without existing ffmpeg dependency" && proceed=true; break;;
                No ) fail "exiting..." exit;;
            esac
        done
    fi

    if $proceed; then
        sudo pacman -S --noconfirm mpv
    fi
}

is_installed() {
   check_if_installed mpv
}

configure() {
    symlink_dotlink "${DOTFILES}/mpv" "$HOME/.config/mpv"
}

is_configured() {
    validate_dotlink "${DOTFILES}/mpv" "$HOME/.config/mpv"
}
