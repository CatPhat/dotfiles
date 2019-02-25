#!/bin/sh
test -d /usr/share/fzf || return 0

export FZF_COMPLETION_TRIGGER='**'

# shellcheck disable=SC1091
. /usr/share/fzf/completion.zsh
