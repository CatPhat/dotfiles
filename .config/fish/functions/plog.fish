function plog --description "add personal-log entry, plog <plog title> <optional log statement arg(s)>"
    set -l argcount (count $argv)
    if test $argcount -eq 0;
       printf "No title provided.\nUsage: plog <title> <optional log body statement(s)>"
    else
        set -l tempfile (mktemp)
        set -l plog ~/.todo/personal-todo
        set -l plogcountfile ~/.todo/.personal-todo-count
        set -l entrycount (math (cat $plogcountfile) + 1)
        set -l title (printf "PLOG ENTRY #%s - %s :: %s" $entrycount (date +%Y%m%d%H%M%S) $argv[1]) | tr '\n' ' '

        printf "\nBEGIN %s\n" $title >> $plog

        if test $argcount -gt 1;
            for i in $argv[2..-1]
                printf "%s\n" $i >> $tempfile
            end
        end

        nvim $tempfile >/dev/tty
        cat $tempfile >> $plog
        rm $tempfile
        printf "END LOG ENTRY\n" >> $plog
        echo "$title >>> saved to $plog"
        echo $entrycount > $plogcountfile
    end
end plog
