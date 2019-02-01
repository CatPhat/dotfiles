#!/usr/bin/env bash

sudo pacman -S --noconfirm \
    noto-fonts \
    noto-fonts-emoji

trizen -S --noconfirm \
    nerd-fonts-complete

fc-cache -fv
