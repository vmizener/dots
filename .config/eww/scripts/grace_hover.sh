#!/bin/sh

# Usage:
#   grace_hover.sh [VAR]
#   grace_hoverlost.sh [VAR] [GRACE]
#
# Use with `./scripts/grace_hoverlost.sh`
# Updates $VAR only if hover is still lost after $GRACE seconds
#
# E.g.
#
# :onhover "./scripts/grace_hover.sh bool_topbar-right-hover"
# :onhoverlost "./scripts/grace_hoverlost.sh bool_topbar-right-hover 0.5"

VAR=$1

LOCK_FILE="$HOME/.cache/eww-grace-$VAR.lock"

if [[ -f "$LOCK_FILE" ]]; then
    rm -f "$LOCK_FILE"
fi
eww update "${VAR}=true"
