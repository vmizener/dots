#!/usr/bin/env bash
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
# shellcheck source=./lib.sh
source "$SCRIPTPATH/lib.sh"

LOGPATH=/tmp/sway-daemons.log
rm "$LOGPATH"
function log() {
    echo "$1" >> $LOGPATH
}
log "Running as user '$USER'"

##

PATH=.
PATH=$PATH:${HOME}/.local/bin
PATH=$PATH:${HOME}/.cargo/bin
PATH=$PATH:${HOME}/go/bin
PATH=$PATH:/usr/local/sbin
PATH=$PATH:/usr/local/bin
PATH=$PATH:/usr/sbin
PATH=$PATH:/usr/bin
PATH=$PATH:/sbin
PATH=$PATH:/bin

log "Running with PATH: $PATH"

###

# Clipboard manager
if lib::exists wl-paste cliphist; then
    # Prefer cliphist (supports image clipboard)
    killall -q wl-paste
    wl-paste --type text --watch cliphist store &   # Stores only text data
    wl-paste --type image --watch cliphist store &  # Stores only image data
elif lib::exists wl-paste clipman; then
    # Fallback on clipman
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
if lib::exists eww; then
    # Prefer eww
    eww open topbar
elif lib::exists waybar; then
    # Fallback on waybar
    killall -q waybar
    while pgrep -x waybar >/dev/null; do sleep 1; done
    waybar &
fi

# CKB
if lib::exists ckb-next; then
    killall -q -u $USER ckb-next
    ckb-next -b &
fi

