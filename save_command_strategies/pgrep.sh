#!/usr/bin/env bash

# Prints one line per pane pid given: the command line of the process in the pane's
# foreground, or an empty line when that is the pane's own shell.

full_command() {
	local leader="$(ps -o tpgid= -p "$1" | tr -d ' ')"
	[[ -z "$leader" || "$leader" == "$1" ]] && return
	\pgrep -lf -g "$leader" | awk -v leader="$leader" '$1 == leader { sub(/^[0-9]+ /, ""); print; exit }'
}

for pane_pid in "$@"; do
	echo "$(full_command "$pane_pid")"
done
