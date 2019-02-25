#!/usr/bin/env bash

sudo rm -fr /etc/pacman.d/gnupg \
    && sudo pacman-key --init \
    && sudo pacman-key --populate archlinux \
    && sudo pacman -Syu --needed --noconfirm \
       base base-devel reflector git

# Update package mirrorlist, use fastest mirrors available
sudo reflector --verbose --latest 40 --number 10 --sort rate --protocol http --save /etc/pacman.d/mirrorlist
