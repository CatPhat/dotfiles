#!/bin/bash

BACKUP_DIR="/mnt/ssd2/backup/abox-full-system"

sudo rsync -aAX --info=progress2 --delete --exclude={"/home/user9/vadmin-sshfs","/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found","/home/*/.cache/chromium/*"} / $BACKUP_DIR
