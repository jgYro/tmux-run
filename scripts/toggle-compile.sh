#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"
PANE_FILE="/tmp/tmux_compile_pane"

# Get current pane ID
CURRENT_PANE=$(tmux display-message -p '#{pane_id}')

if [ -f "$PANE_FILE" ]; then
    PANE_ID=$(cat "$PANE_FILE" 2>/dev/null)
    if [ -n "$PANE_ID" ] && tmux list-panes -a -F "#{pane_id}" | grep -q "^$PANE_ID$"; then
        # Check if we're already in the compile pane
        if [ "$CURRENT_PANE" = "$PANE_ID" ]; then
            # Already in compile pane - just clear and get new prompt
            tmux send-keys C-c  # Exit copy mode if active
            tmux send-keys Enter  # Get new Run: prompt
            exit 0
        else
            # Pane exists but we're not in it - focus it and clear
            tmux select-pane -t "$PANE_ID"
            tmux send-keys -t "$PANE_ID" C-c  # Exit copy mode if active
            tmux send-keys -t "$PANE_ID" Enter  # Get new Run: prompt
            exit 0
        fi
    else
        # Pane file exists but pane is gone - clean up
        rm -f "$PANE_FILE"
    fi
fi

# Create new compile pane - always split from the main (first) pane
tmux split-window -t 0 -v -p 20 -c "#{pane_current_path}" "echo \$TMUX_PANE > /tmp/tmux_compile_pane && $CURRENT_DIR/compile.sh; rm -f /tmp/tmux_compile_pane"
