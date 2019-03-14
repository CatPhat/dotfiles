#!/bin/sh

#nvidia-settings -l -a InitialPixmapPlacement=0 &
nvidia-settings -l &
systemctl --user import-environment DISPLAY
~/.dotfiles/.config/feh/.fehbg &