#!/usr/bin/env bash

LAST_COMMAND_FILE="/tmp/tmux_last_compile_command"

while true; do
    clear

    # Load last command if it exists
    if [[ -f "$LAST_COMMAND_FILE" ]]; then
        last_command=$(cat "$LAST_COMMAND_FILE" 2>/dev/null)
        if [[ -n "$last_command" ]]; then
            read -p "Run ($last_command): " -e command
            # If user just pressed enter, use the last command
            if [[ -z "$command" ]]; then
                command="$last_command"
            fi
        else
            read -p "Run: " command
        fi
    else
        read -p "Run: " command
    fi

    if [[ "$command" == "exit" || "$command" == "quit" ]]; then
        break
    fi

    # Save the command for next time
    echo "$command" > "$LAST_COMMAND_FILE"

    sh -c "$command"

    # Clear screen and enable tmux vi copy mode after command completion
    if [[ -n "$TMUX" ]]; then
        clear
        tmux set-window-option mode-keys vi > /dev/null 2>&1
        tmux copy-mode
        tmux send-keys -X history-top

        # After copy mode, wait for explicit input to exit
        sleep 1  # Give copy mode time to activate
        read -n1 response
        if [[ "$response" == "q" ]]; then
            break
        fi
    else
        echo ""
        read -p "Press Enter to continue..."
    fi
done
