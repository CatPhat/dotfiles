#!/usr/bin/env bash

# Termite all instances
killall -q polybar

# wait until shutdown
while pgrep -U $UID -x polybar >/dev/null; do sleep 1; done

# Launch
polybar main &
