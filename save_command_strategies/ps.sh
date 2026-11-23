#!/usr/bin/env bash

# Prints one line per pane pid given: the command line of the pane's child process,
# or an empty line when it has none.

full_command() {
	ps -ao "ppid=,args=" | awk -v pid="$1" '$1 == pid { sub(/^ *[0-9]+ /, ""); print; exit }'
}

for pane_pid in "$@"; do
	echo "$(full_command "$pane_pid")"
done
