#!/usr/bin/env bash
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
# shellcheck source=./lib.sh
source "$SCRIPTPATH/lib.sh"

lib::init
lib::log "Starting daemons as user '$USER'"

# Clipboard manager
if lib::exists wl-paste cliphist; then
    # Prefer cliphist (supports image clipboard)
    killall -q wl-paste
    wl-paste --type text --watch cliphist store &   # Stores only text data
    wl-paste --type image --watch cliphist store &  # Stores only image data
    lib::log 'Using `cliphist` as clipboard manager'
elif lib::exists wl-paste clipman; then
    # Fallback on clipman
    killall -q wl-paste
    wl-paste -t text --watch clipman store &
    lib::log 'Using `clipman` as clipboard manager'
fi

# Clipboard sync
if lib::exists julia; then
    ps -ef | grep "[c]lipboard_sync" | tr -s ' ' | cut -d' ' -f2 | xargs kill
    ~/.config/sway/clipboard_sync.jl >/dev/null 2>&1 &
    lib::log 'Initialized clipboard sync'
fi

# Inhibit idle while playing audio or listening on mic
if lib::exists sway-audio-idle-inhibit; then
    killall -q sway-audio-idle-inhibit
    sway-audio-idle-inhibit &
    lib::log 'Initialized `sway-audio-idle-inhibit`'
fi

# Gesture control
if lib::exists fusuma; then
    killall -q fusuma
    fusuma -d
    lib::log 'Initialized gesture control'
fi

# Display manager
if lib::exists kanshi; then
    killall -q kanshi
    kanshi &
    lib::log 'Initialized output/display detection'
fi

# Notification manager
if lib::exists mako; then
    killall -q mako
    mako &
    lib::log 'Initialized notifier'
fi

# Status bar
if lib::exists eww; then
    # Prefer eww
    eww kill
    eww open topbar
    lib::log 'Initialized `eww`'
elif lib::exists waybar; then
    # Fallback on waybar
    killall -q waybar
    while pgrep -x waybar >/dev/null; do sleep 1; done
    waybar &
    lib::log 'Initialized `waybar`'
fi

# CKB
if lib::exists ckb-next; then
    killall -q -u $USER ckb-next
    ckb-next -b &
    lib::log 'Initialized `ckb-next`'
fi

