function d-todo
	set -l todo ~/dotfiles/dtodo
	echo "BEGIN LOG ENTRY - " (date +%Y%m%d%H%M%S) >> $todo
	echo $argv >> $todo
	echo "END LOG ENTRY" >> $todo
	echo "" >> $todo
end
