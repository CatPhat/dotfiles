#!/usr/bin/env bash

source ${DOTFILES}/setup/config.sh

local oceanic_path=${DOTFILES}/oceanic-next-shell/git-repo
mkdir -p ${oceanic_path}
git clone https://github.com/mhartington/oceanic-next-shell.git ${oceanic_path}
local oceanic_source='source ${DOTFILES}/oceanic-next-shell/.source.zshrc.sh'
grep -q "${oceanic_source}" ${DOTFILES_ZSHRC} \
    || echo "${oceanic_source}" >> ${DOTFILES_ZSHRC}
