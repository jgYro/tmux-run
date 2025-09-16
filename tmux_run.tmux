#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Set up the compile key binding
tmux bind-key r run-shell "$CURRENT_DIR/scripts/toggle-compile.sh"
