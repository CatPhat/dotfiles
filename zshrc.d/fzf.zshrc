#!/usr/bin/env sh

export FZF_COMPLETION_TRIGGER='**'


# search history with fzf if installed, default otherwise
if test -d /usr/share/fzf; then
	# shellcheck disable=SC1091
	. /usr/share/fzf/key-bindings.zsh
else
	bindkey '^R' history-incremental-search-backward
fi

# shellcheck disable=SC1091
#. /usr/share/fzf/completion.zsh
. ~/.fzf.zsh
