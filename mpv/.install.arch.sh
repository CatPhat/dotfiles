#!/usr/bin/env bash

source ${DOTFILES}/setup/common.sh

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

