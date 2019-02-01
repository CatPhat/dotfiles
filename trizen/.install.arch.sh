#!/usr/bin/env bash

git clone https://aur.archlinux.org/trizen.git  /tmp/trizen \
    && cd /tmp/trizen \
    && makepkg -si --noconfirm
