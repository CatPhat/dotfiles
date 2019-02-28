#!/usr/bin/env bash

source ${DOTFILES}/setup/common.sh
source ${DOTFILES}/setup/config.sh

install() {
    if ${FULL_FFMPEG_NVENC}; then
        info "Installing ffmpeg-full-nvenc"
        trizen -S --noconfirm ffmpeg-full-nvenc
    else
        info "Installing default ffmpeg package. Set \$FULL_FFMPEG_NVENC to true if ffmpeg-full-nvenc is desired."
        sudo pacman -S --noconfirm ffmpeg
    fi
}

configure() {
    return 77
}

is_installed() {
   check_if_installed ffmpeg
}

is_configured() {
    return 77
}
