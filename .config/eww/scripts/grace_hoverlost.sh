#!/usr/bin/env bash

# Usage:
#   grace_hover.sh [VAR]
#   grace_hoverlost.sh [VAR] [GRACE] [CMD ...]
#
# Use with `./scripts/grace_hoverlost.sh`
# Updates $VAR only if hover is still lost after $GRACE seconds
#
# E.g.
#
# :onhover "./scripts/grace_hover.sh bool_topbar-right-hover"
# :onhoverlost "./scripts/grace_hoverlost.sh bool_topbar-right-hover 0.5"
#
# or
#
# :onhoverlost `./scripts/grace_hoverlost.sh bool_sidebar-visible 0.3 './scripts/eww_popup.sh close sidebar-visible'`

VAR=$1
shift
GRACE=$1
shift

LOCK_FILE="$HOME/.cache/eww-grace-$VAR.lock"
(
    touch "$LOCK_FILE"
    sleep "$GRACE"
    if [[ -f "$LOCK_FILE" ]]; then
        rm -f "$LOCK_FILE"
        while (( "$#" > 0 )); do
            /usr/bin/env bash -c "$1"
            shift
        done
        eww update "${VAR}=false"
    fi
) &
