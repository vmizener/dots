#!/usr/bin/env bash
RUN="${HOME}/scripts/run"
$RUN utils::lib_init

# Notification manager
#killall -q mako
#mako &

# CKB
if $RUN utils::exists ckb-next; then
    killall -q -u "${USER}" ckb-next
    ckb-next -b &
    $RUN utils::log 'Initialized `ckb-next`'
fi

# Clipboard manager
if $RUN utils::exists wl-paste cliphist; then
    # Prefer cliphist (supports image clipboard)
    killall -q wl-paste
    wl-paste --type text --watch cliphist store &   # Stores only text data
    wl-paste --type image --watch cliphist store &  # Stores only image data
    $RUN utils::log 'Using `cliphist` as clipboard manager'
elif $RUN utils::exists wl-paste clipman; then
    # Fallback on clipman
    killall -q wl-paste
    wl-paste -t text --watch clipman store &
    $RUN utils::log 'Using `clipman` as clipboard manager'
else
    $RUN utils::log '[WARNING] No clipboard manager detected'
fi

# Status bar
if $RUN utils::exists eww; then
    # Prefer eww
    eww kill
    # Clear eww lock cache before opening bars
    rm ~/.cache/eww-*.lock
    $RUN eww::popup open topbar
    $RUN utils::log 'Initialized `eww`'
elif $RUN utils::exists waybar; then
    # Fallback on waybar
    killall -q waybar
    while pgrep -x waybar >/dev/null; do sleep 1; done
    waybar &
    $RUN utils::log 'Initialized `waybar`'
else
    $RUN utils::log '[WARNING] No bar'
fi

# Dropbox
if $RUN utils::exists dropbox; then
    if ! [[ "$(dropbox-cli status)" =~ "Up to date" ]]; then
        killall -q dropbox
        dropbox
        $RUN utils::log 'Initialized dropbox'
    else
        $RUN utils::log 'Dropbox is running'
    fi
fi
