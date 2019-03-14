#!/bin/zsh
# shortcut to this dotfiles path is $DOTFILES
export DOTFILES="${ENV_DOTFILES}"

# your project folder that we can `c [tab]` to
export PROJECTS="$HOME/dev"

# your default editor
export EDITOR='vim'
export VEDITOR='code'

# all of our zsh files
typeset -U config_files
config_files=($DOTFILES/*/*.zsh)

# load the path files
for file in ${(M)config_files:#*/path.zsh}; do
  source "$file"
done

autoload -Uz compinit
# load everything but the path and completion files
for file in ${${config_files:#*/path.zsh}:#*/completion.zsh}; do
  source "$file"
done

typeset -i updated_at=$(date +'%j' -r ~/.zcompdump 2>/dev/null || stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
if [ $(date +'%j') != $updated_at ]; then
  compinit -i
else
  compinit -C -i
fi

# load antibody plugins
source ~/.zsh_plugins.sh


# load every completion after autocomplete loads
for file in ${(M)config_files:#*/completion.zsh}; do
  source "$file"
done

unset config_files updated_at

# use .localrc for SUPER SECRET CRAP that you don't
# want in your public, versioned repo.
# shellcheck disable=SC1090
[ -f ~/.localrc ] && . ~/.localrc

export LSCOLORS='exfxcxdxbxegedabagacad'
export CLICOLOR=true

fpath=($DOTFILES/functions $fpath)

autoload -U "$DOTFILES"/functions/*(:t)
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# don't nice background tasks
setopt NO_BG_NICE
setopt NO_HUP
setopt NO_BEEP
# allow functions to have local options
setopt LOCAL_OPTIONS
# allow functions to have local traps
setopt LOCAL_TRAPS
# share history between sessions ???
setopt SHARE_HISTORY
# add timestamps to history
setopt EXTENDED_HISTORY
setopt PROMPT_SUBST
setopt CORRECT
setopt COMPLETE_IN_WORD
# adds history
setopt APPEND_HISTORY
# adds history incrementally and share it across sessions
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
# don't record dupes in history
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY
setopt HIST_EXPIRE_DUPS_FIRST
# dont ask for confirmation in rm globs*
setopt RM_STAR_SILENT

#zle -N up-line-or-beginning-search
#zle -N down-line-or-beginning-search

bindkey -v

# fuzzy find: start to type
#bindkey "$terminfo[kcuu1]" up-line-or-beginning-search
#bindkey "$terminfo[kcud1]" down-line-or-beginning-search
#bindkey "$terminfo[cuu1]" up-line-or-beginning-search
#bindkey "$terminfo[cud1]" down-line-or-beginning-search

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

# backward and forward word with option+left/right
bindkey '^[^[[D' backward-word
bindkey '^[b' backward-word
bindkey '^[^[[C' forward-word
bindkey '^[f' forward-word

# to to the beggining/end of line with fn+left/right or home/end
bindkey "${terminfo[khome]}" beginning-of-line
bindkey '^[[H' beginning-of-line
bindkey "${terminfo[kend]}"  end-of-line
bindkey '^[[F' end-of-line

# delete char with backspaces and delete
bindkey '^[[3~' delete-char
bindkey '^?' backward-delete-char

# delete word with ctrl+backspace
bindkey '^[[3;5~' backward-delete-word
# bindkey '^[[3~' backward-delete-word

# search history with fzf if installed, default otherwise
if test -d /usr/share/fzf; then
	# shellcheck disable=SC1091
	. /usr/share/fzf/key-bindings.zsh
else
	bindkey '^R' history-incremental-search-backward
fi
