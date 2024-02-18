#!/usr/bin/env bash
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
# shellcheck source=./lib.sh
source "$SCRIPTPATH/lib.sh"
lib::init

if lib::exists cliphist; then
    # Prefer cliphist (supports image clipboard)
    cliphist list | wofi -d | cliphist decode | wl-copy
elif lib::exists clipman; then
    # Fallback on clipman
    clipman pick -t wofi
else
    swaynag -m "No clipboard manager available!"
fi
