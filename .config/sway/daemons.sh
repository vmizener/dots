#!/usr/bin/env bash
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
# shellcheck source=./lib.sh
source "$SCRIPTPATH/lib.sh"

lib::init --reset
lib::log "Starting daemons as user '$USER'"
lib::log "Running with PATH: $PATH"
lib::log "Running with ENV:\n$(env)"

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
else
    lib::log '[WARNING] No clipboard manager detected'
fi

# Clipboard sync
if lib::exists julia; then
    ps -ef | grep "[c]lipboard_sync" | tr -s ' ' | cut -d' ' -f2 | xargs kill
    ~/.config/sway/clipboard_sync.jl >/dev/null 2>&1 &
    lib::log 'Initialized clipboard sync'
else
    lib::log '[WARNING] No julia installation available'
fi

# Inhibit idle while playing audio or listening on mic
if lib::exists sway-audio-idle-inhibit; then
    killall -q sway-audio-idle-inhibit
    sway-audio-idle-inhibit &
    lib::log 'Initialized `sway-audio-idle-inhibit`'
fi

# Dropbox
if lib::exists dropbox; then
    if ! [[ "$(dropbox-cli status)" =~ "Up to date" ]]; then
        killall -q dropbox
        dropbox
        lib::log 'Initialized dropbox'
    else
        lib::log 'Dropbox is running'
    fi
fi

# Gesture control
if lib::exists fusuma; then
    # https://github.com/iberianpig/fusuma
    # Also needs fusuma-plugin-sendkey (see bottom of github)
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
    killall -q xfce4-notifyd  # Kill xfce4-notifyd if that's running
    killall -q mako
    mako &
    lib::log 'Initialized notifier'
else
    lib::log '[WARNING] No notifier'
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
else
    lib::log '[WARNING] No bar'
fi

# CKB
if lib::exists ckb-next; then
    killall -q -u $USER ckb-next
    ckb-next -b &
    lib::log 'Initialized `ckb-next`'
fi

# Language IME
if lib::exists fcitx5; then
    fcitx5 -r &
    lib::log 'Initialized `fcitx5`'
fi
