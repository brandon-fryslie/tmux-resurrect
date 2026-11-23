#!/usr/bin/env bash

# Prints one line per pane pid given: the command line of the process in the pane's
# foreground, or an empty line when that is the pane's own shell.

full_command() {
	# tpgid is the 6th field after the parenthesized command name, which may hold spaces.
	local leader="$(sed 's/.*) //' "/proc/$1/stat" | cut -d' ' -f6)"
	[[ -z "$leader" || "$leader" == "$1" ]] && return
	# See: https://unix.stackexchange.com/a/567021
	# Avoid complications with system printf by using bash subshell interpolation.
	# This will properly escape sequences and null in cmdline.
	cat /proc/${leader}/cmdline | xargs -0 bash -c 'printf "%q " "$0" "$@"'
}

for pane_pid in "$@"; do
	echo "$(full_command "$pane_pid")"
done
