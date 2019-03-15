#!/bin/sh

INIT_BARRIER_CMD='/usr/bin/barrierc -f -d FATAL --no-tray --enable-crypto -n abox whitebox.vuser.us-c.vedos.io:24800'
/usr/bin/pgrep -lxf "$INIT_BARRIER_CMD" || ( ( $INIT_BARRIER_CMD ) & )