function expand_command --on-event fish_postexec
    echo "argv: $argv" >> $HOME/expand_command.log
end
