#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Set up the compile key binding
tmux bind-key r run-shell "$CURRENT_DIR/scripts/toggle-compile.sh" \; run-shell "if [ -f /tmp/tmux_compile_pane ] && [ \$(tmux display-message -p '#{pane_id}') != \$(cat /tmp/tmux_compile_pane) ]; then sleep 0.1; tmux select-pane -t \$(cat /tmp/tmux_compile_pane); fi"
