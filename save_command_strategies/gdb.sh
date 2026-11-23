#!/usr/bin/env bash

# Prints one line per pane pid given: the last line of the pane shell's history.

full_command() {
	gdb -batch --eval "attach $1" --eval "call write_history(\"/tmp/bash_history-$1.txt\")" --eval 'detach' --eval 'q' >/dev/null 2>&1
	\tail -1 "/tmp/bash_history-$1.txt"
}

for pane_pid in "$@"; do
	echo "$(full_command "$pane_pid")"
done
