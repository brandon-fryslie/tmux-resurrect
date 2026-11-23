#!/usr/bin/env bash

# Prints one line per pane pid given: the command line of the process in the pane's
# foreground, or an empty line when that is the pane's own shell.

ps -axo "pid=,tpgid=,args=" | awk -v panes="$*" '
	{ pid = $1; foreground[pid] = $2; sub(/^ *[0-9]+ +-?[0-9]+ /, ""); args[pid] = $0 }
	END {
		count = split(panes, pane, " ")
		for (i = 1; i <= count; i++) {
			leader = foreground[pane[i]]
			print (leader == pane[i] ? "" : args[leader])
		}
	}'
