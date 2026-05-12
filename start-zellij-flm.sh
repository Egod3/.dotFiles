#!/bin/bash
#
# start-zellij-flm.sh
# Zellij equivalent of start-tmux-eg-linux.sh.
# Tested on Xubuntu 24.04 / Pop!_OS 22.04 with zellij installed via:
#   - cargo install zellij, OR
#   - the official tarball from https://github.com/zellij-org/zellij/releases
#
# Behavior:
#   - If a zellij session named $SESSION_NAME exists, attach to it.
#   - Otherwise, if $SESSION_NAME == "flm", create it from flm-layout.kdl.
#   - Any other unknown session name exits without doing anything (matches
#     the original tmux script's behavior).

set -u

# Take the session name as $1, default to "flm".
if [[ "${1:-}" != "" ]]; then
    SESSION_NAME="$1"
else
    SESSION_NAME="flm"
fi

# Locate the layout file next to this script (regardless of where it is
# invoked from).
SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"
LAYOUT_FILE="$SCRIPT_DIR/flm-layout.kdl"

# Check whether a zellij session with this exact name already exists.
# zellij list-sessions emits ANSI color codes and lines like:
#   flm [Created 5m 23s ago]
#   old-thing [Created 1d ago] (EXITED - attach to resurrect)
# We strip the color codes, take the first whitespace-delimited token, and
# match the name exactly. Exited sessions count as "exists" -- attaching to
# an exited session resurrects it, which is usually what you want.
session_exists() {
    zellij list-sessions 2>/dev/null \
        | sed -r 's/\x1B\[[0-9;]*[mK]//g' \
        | awk '{print $1}' \
        | grep -Fxq "$1"
}

if ! command -v zellij >/dev/null 2>&1; then
    echo "zellij not found in PATH. Install it first:" >&2
    echo "  cargo install --locked zellij" >&2
    echo "  # or grab a release from https://github.com/zellij-org/zellij/releases" >&2
    exit 127
fi

# if session_exists "$SESSION_NAME"; then
#     echo "Attaching to existing session: $SESSION_NAME"
#     exec zellij attach "$SESSION_NAME"
# fi

echo "No existing session named '$SESSION_NAME'. Creating a new one."

if [[ "$SESSION_NAME" == "flm" ]]; then
    if [[ ! -f "$LAYOUT_FILE" ]]; then
        echo "Layout file not found: $LAYOUT_FILE" >&2
        exit 1
    fi
    exec zellij -n "$LAYOUT_FILE" --session "$SESSION_NAME"
else
    echo "unknown session name ($SESSION_NAME), nothing to do"
    exit 0
fi
