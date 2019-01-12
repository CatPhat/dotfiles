#!/bin/bash

scrot $1 ~/incoming/screenshots/%Y-%m-%d_%k:%M:%S.png -e 'notify-send "scrot" "saved: $f"'
