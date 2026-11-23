#!/usr/bin/env bash

# Prints one line per pane pid given: the command line of the pane's child process,
# or an empty line when it has none.

full_command() {
	\pgrep -lf -P "$1" | head -n 1 | cut -d' ' -f2-
}

for pane_pid in "$@"; do
	echo "$(full_command "$pane_pid")"
done
