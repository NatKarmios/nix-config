#
# ccsend - Send a command to the Claude Code pane in current tmux session
#
# Credit to Andrey Popp
# https://github.com/andreypopp/cctools
#
# Usage:
#   ccsend "your command here"
#   echo "your command" | ccsend
#

set -eu

# Get command from argument or stdin
if [ $# -gt 0 ]; then
    CMD="$*"
else
    CMD=$(cat)
fi

if [ -z "$CMD" ]; then
    echo "error: no command provided" >&2
    echo "Usage: ccsend <command> or echo <command> | ccsend" >&2
    exit 1
fi

# Check if we're in tmux
if [ -z "${TMUX:-}" ]; then
    echo "error: not running inside tmux" >&2
    exit 1
fi

# Cache pane lists (pid:pane_id per line) for current window and current session
WINDOW_PANE_LIST=$(tmux list-panes -F '#{pane_pid}:#{pane_id}')
SESSION_PANE_LIST=$(tmux list-panes -s -F '#{pane_pid}:#{pane_id}')

# Find pane ID for a given PID within a given pane list
find_pane_for_pid() {
    local search_pid=$1
    local pane_list=$2
    echo "$pane_list" | grep "^${search_pid}:" | cut -d: -f2 | head -1
}

# Walk up the process tree from each claude PID to find the tmux pane,
# searching within the given pane list
find_panes() {
    local pane_list=$1
    local found=""
    for claude_pid in $CLAUDE_PIDS; do
        pid=$claude_pid
        while [ -n "$pid" ] && [ "$pid" != "1" ]; do
            result=$(find_pane_for_pid "$pid" "$pane_list")
            if [ -n "$result" ]; then
                # Add to list if not already present
                if ! echo "$found" | grep -q "^${result}$"; then
                    found="${found}${found:+$'\n'}${result}"
                fi
                break
            fi
            pid=$(ps -o ppid= -p "$pid" 2>/dev/null | tr -d ' ')
        done
    done
    echo "$found"
}

# Find claude processes (try exact match first, then broader search)
CLAUDE_PIDS=$(pidof "claude" 2>/dev/null || pgrep -f "node.*claude" 2>/dev/null || true)

if [ -z "$CLAUDE_PIDS" ]; then
    echo "error: Claude Code is not running" >&2
    exit 1
fi

# Check panes in the current window first, then fall back to the whole session
FOUND_PANES=$(find_panes "$WINDOW_PANE_LIST")
SCOPE="window"
if [ -z "$FOUND_PANES" ]; then
    FOUND_PANES=$(find_panes "$SESSION_PANE_LIST")
    SCOPE="session"
fi

if [ -z "$FOUND_PANES" ]; then
    echo "error: could not find Claude Code pane in current session" >&2
    exit 1
fi

PANE_COUNT=$(echo "$FOUND_PANES" | wc -l | tr -d ' ')
if [ "$PANE_COUNT" -gt 1 ]; then
    echo "error: multiple Claude Code instances found in current $SCOPE" >&2
    exit 1
fi

PANE_ID="$FOUND_PANES"

# Send the command to the pane
tmux send-keys -t "$PANE_ID" -l "$CMD"
sleep 0.1
tmux send-keys -t "$PANE_ID" Enter
