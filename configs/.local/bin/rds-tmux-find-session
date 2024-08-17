#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

selected_session=$(tmux list-sessions -F '#{session_id}: #{session_name}' | fzf | awk '{print $2}')

tmux switch-client -t "$selected_session"
