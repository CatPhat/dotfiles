#!/usr/bin/env bash

choice=`find /etc/netctl -maxdepth 1 -type f -printf "%f\n" | rofi -dmenu`;
if [ -n "$choice" ]; then
    sudo netctl switch-to $choice;
fi
