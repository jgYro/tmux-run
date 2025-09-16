# tmux-run

A tmux plugin that provides an Emacs-style compile function for running commands in a persistent pane.

## Features

- Press `prefix + r` to create/access a compile pane
- Remembers last command and offers it as default
- Works from any pane, always creates compile pane in consistent location
- Persistent pane that stays open until manually closed

## Installation

### TPM (Tmux Plugin Manager)

Add to `.tmux.conf`:
```
set -g @plugin 'jgYro/tmux-run'
```

Press `prefix + I` to install.

### Manual

Clone this repository and add to `.tmux.conf`:
```
run-shell '/path/to/tmux-run/tmux_run.tmux'
```

## Usage

- `prefix + r` - Create/access compile pane
- Type commands at "Run:" prompt or press Enter to rerun last command
- `exit`, `quit`, or Ctrl-C twice to exit the compile pane

## Behavior

The first press creates a compile pane, occupying 20% of the main pane’s height. Subsequent presses focus the existing pane and present a new prompt. After the keybind is triggered, focus automatically shifts to the compile pane, Vim mode is enabled, and the view scrolls to the top of the command output. The pane persists across tmux sessions until it is manually closed.

## Known Bugs, Open to PR's
- This is a bit hacky with no customization of defaults since currently it is configured how I'd use it.
- You do have to press ctrl-c twice to exit the prompt which could be improved
- Pressing the prefix-r keybind more than once within 0.1 seconds will cause an error (again, hacky setup)
