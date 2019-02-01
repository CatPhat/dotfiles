#!/usr/bin/env bash

sudo pacman -S --noconfirm feh

if [[ $(grep -q "fehbg" "$HOME/.xinitrc") == false ]] ; then
    info "Adding fehbg background initialization script to .xinitrc"
    echo "${DOTFILES}/feh/.fehbg &" >> "$HOME/.xinitrc"
fi
