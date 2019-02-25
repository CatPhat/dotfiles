#!/bin/bash

FILENAME="$HOME/incoming/screenshots/$(date +"%FT%T").png"

case $1 in
    -s | --select)
        ERROR=`maim -s "$FILENAME" 2>&1`
    ;;
    -aw | --active-window)
        ERROR=`maim -i $(xdotool getactivewindow) "$FILENAME" 2>&1`
    ;;
    -d | --desktop)
        ERROR=`maim "$FILENAME" 2>&1`
    ;;
esac

if [[ $? -eq 0 ]]; then
    notify-send "Screenshot" "saved to to: $FILENAME"
else
    notify-send "ERROR: Screenshot" "$ERROR" -u critical
fi
