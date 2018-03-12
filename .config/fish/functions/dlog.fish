function dlog
	set -l tempfile (mktemp)
        set -l dlog ~/dotfiles/dlog
	
	trap 'rm ~/$tempfile' EXIT;
	nvim $tempfile >/dev/tty;

        echo "BEGIN LOG ENTRY - " (date +%Y%m%d%H%M%S) >> $dlog
	cat $tempfile >> ~/dotfiles/dlog
        echo "END LOG ENTRY" >> $dlog
        echo "" >> $dlog
end dlog
