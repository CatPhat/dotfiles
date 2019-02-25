#!/usr/bin/env bash

source ${DOTFILES}/golang/.install.path.zsh.sh

sudo pacman -S --noconfirm \
    go \
    go-tools
