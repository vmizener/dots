#!/usr/bin/env bash
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
# shellcheck source=./lib.sh
source "$SCRIPTPATH/lib.sh"
LOGPATH=/tmp/sway-daemons.log
rm "$LOGPATH"

###

# Clipboard manager
if lib::exists wl-paste clipman; then
    killall -q wl-paste
    wl-paste -t text --watch clipman store &
fi

# Clipboard sync
if lib::exists julia; then
    ps -ef | grep "[c]lipboard_sync" | tr -s ' ' | cut -d' ' -f2 | xargs kill
    ~/.config/sway/clipboard_sync.jl >/dev/null 2>&1 &
fi

# Inhibit idle while playing audio or listening on mic
if lib::exists sway-audio-idle-inhibit; then
    killall -q sway-audio-idle-inhibit
    sway-audio-idle-inhibit &
fi

# Gesture control
if lib::exists fusuma; then
    killall -q fusuma
    fusuma -d
fi

# Display manager
if lib::exists kanshi; then
    killall -q kanshi
    kanshi &
fi

# Notification manager
if lib::exists mako; then
    killall -q mako
    mako &
fi

# Status bar
if lib::exists waybar; then
    killall -q waybar
    while pgrep -x waybar >/dev/null; do sleep 1; done
    waybar &
fi

# CKB
if lib::exists ckb-next; then
    killall -q -u $USER ckb-next
    ckb-next -b &
fi

