# Base16 Shell
if status --is-interactive
    eval sh $HOME/.config/base16-shell/scripts/base16-ocean.sh
    source $HOME/.config/base16-shell/profile_helper.fish
end

alias tmux='tmux -f $HOME/.config/tmux/tmux.conf'

set -x EDITOR "nvim"
set -x VISUAL "nvim"
set -x BROWSER "chromium"
set -x TERMCMD "termite"
set -x WEECHAT_HOME "$HOME/.config/weechat"
set -x ENV_SET "yes"
#set -x TERM "xterm-256color"
#set -x TERMINAL "termite"
set -x TERMINFO "$HOME/.terminfo"
set -x NVIM_LOG_FILE "$HOME/.local/dotlogs/nvim/log"
#set -x GOBIN "/usr/bin/go/bin"
set -x -U GOPATH "$HOME/dev/go"
set PATH $PATH $GOPATH/bin

set -g theme_powerline_fonts yes
set -g theme_color_scheme base16
set -g theme_nerd_fonts no

set -x LESS '-g -i -F -M -R -w -X -z-4'

# Disable history file
set -x LESSHISTFILE "-"

set -x CXX 'g++'
set -x CC 'gcc'

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
#if count $argv[(i)lesspipe(|.sh)]
#  set LESSOPEN "| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
#end

#function expand_command --on-event fish_preexec
#    echo "argv: $argv" >> $HOME/expand_command.log
#    #printf "\033k(echo "$argv" | cut -d" " -f1)\033\\" >> $HOME/expand_command.log
#    echo "  " >> $HOME/expand_command.log
#    echo "---" >> $HOME/expand_command.log
#    echo "  " >> $HOME/expand_command.log
#end
#
## Set the tmux window title, depending on whether we are running something, or just prompting
#function fish_title
#    if [ "fish" != $_ ]
#        tmux rename-window "$_ $argv"
#    else
#        tmux_directory_title
#    end
#end
#
#function tmux_directory_title
#    if [ "$PWD" != "$LPWD" ]
#        set LPWD "$PWD"
#        set INPUT $PWD
#        set SUBSTRING (eval echo $INPUT| awk '{ print substr( $0, length($0) - 19, length($0) ) }')
#        tmux rename-window "..$SUBSTRING"
#    end
#end
#
###--- Temporary Files ---###
if test ! -d "$TMPDIR"
  set -x TMPDIR "/tmp/$LOGNAME"
  mkdir -p -m 700 "$TMPDIR"
end

#set -x TMPPREFIX "${TMPDIR%/}/termite"
#TMPPREFIX="${TMPDIR%/}/zsh"

# SSH agent socket
set -x SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/ssh-agent.socket"

fish_vi_key_bindings



#setenv SSH_ENV $HOME/.ssh/environment

