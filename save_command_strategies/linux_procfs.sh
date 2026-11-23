#!/usr/bin/env bash

# Prints one line per pane pid given: the command line of the pane's child process,
# or an empty line when it has none.

full_command() {
	local command_pid="$(pgrep -P "$1" | head -n 1)"
	[[ -z "$command_pid" ]] && return
	# See: https://unix.stackexchange.com/a/567021
	# Avoid complications with system printf by using bash subshell interpolation.
	# This will properly escape sequences and null in cmdline.
	cat /proc/${command_pid}/cmdline | xargs -0 bash -c 'printf "%q " "$0" "$@"'
}

for pane_pid in "$@"; do
	echo "$(full_command "$pane_pid")"
done
