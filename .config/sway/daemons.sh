#!/usr/bin/env bash
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
# shellcheck source=./lib.sh
source "$SCRIPTPATH/lib.sh"

lib::init --reset
lib::log "Starting daemons as user '$USER'"
lib::log "Running with PATH:"
echo "$PATH" | lib::log
lib::log "Running with ENV:"
env          | lib::log

# Clipboard manager
if lib::exists wl-paste cliphist; then
    # Prefer cliphist (supports image clipboard)
    lib::log '<<< wl-paste cliphist'
    killall -q wl-paste
    wl-paste --type text --watch cliphist store &   # Stores only text data
    wl-paste --type image --watch cliphist store &  # Stores only image data
    lib::log '>>> wl-paste cliphist'
    lib::log 'Using `cliphist` as clipboard manager'
elif lib::exists wl-paste clipman; then
    # Fallback on clipman
    lib::log '<<< wl-paste clipman'
    killall -q wl-paste
    wl-paste -t text --watch clipman store &
    lib::log '>>> wl-paste clipman'
    lib::log 'Using `clipman` as clipboard manager'
else
    lib::log '[WARNING] No clipboard manager detected'
fi

# Clipboard sync
if lib::exists julia; then
    lib::log 'Initializing clipboard sync'
    lib::log '<<< ~/.config/sway/clipboard_sync.jl'
    ps -ef | grep "[c]lipboard_sync" | tr -s ' ' | cut -d' ' -f2 | xargs kill
    ~/.config/sway/clipboard_sync.jl >/dev/null 2>&1 &
    lib::log '>>> ~/.config/sway/clipboard_sync.jl'
else
    lib::log '[WARNING] No julia installation available'
fi

# Inhibit idle while playing audio or listening on mic
if lib::exists sway-audio-idle-inhibit; then
    lib::log 'Initializing `sway-audio-idle-inhibit`'
    lib::log '<<< sway-audio-idle-inhibit'
    killall -q sway-audio-idle-inhibit
    sway-audio-idle-inhibit &
    lib::log '>>> sway-audio-idle-inhibit'
fi

# Dropbox
if lib::exists dropbox; then
    if ! [[ "$(dropbox-cli status)" =~ "Up to date" ]]; then
        lib::log 'Initializing dropbox'
        lib::log '<<< dropbox'
        killall -q dropbox
        dropbox
        lib::log '>>> dropbox'
    else
        lib::log 'Dropbox is running'
    fi
fi

# Gesture control
if lib::exists fusuma; then
    # https://github.com/iberianpig/fusuma
    # Also needs fusuma-plugin-sendkey (see bottom of github)
    lib::log 'Initializing gesture control'
    lib::log '<<< fusuma'
    killall -q fusuma   2>&1 | lib::log
    fusuma -d           2>&1 | lib::log
    lib::log '>>> fusuma'
fi

# Display manager
if lib::exists kanshi; then
    lib::log 'Initializing output/display detection'
    lib::log '<<< kanshi'
    killall -q kanshi   2>&1 | lib::log
    kanshi &
    lib::log '>>> kanshi'
fi

# Notification manager
if lib::exists mako; then
    killall -q xfce4-notifyd  # Kill xfce4-notifyd if that's running
    lib::log 'Initializing notifier'
    lib::log '<<< mako'
    killall -q mako 2>&1 | lib::log
    mako &
    lib::log '>>> mako'
else
    lib::log '[WARNING] No notifier'
fi

# Status bar
if lib::exists eww; then
    # Prefer eww
    lib::log 'Initializing `eww`'
    lib::log '<<< eww'
    eww kill        2>&1 | lib::log
    eww open topbar 2>&1 | lib::log
    lib::log '>>> eww'
elif lib::exists waybar; then
    # Fallback on waybar
    lib::log 'Initializing `waybar`'
    lib::log '<<< waybar'
    killall -q waybar
    while pgrep -x waybar >/dev/null; do sleep 1; done
    waybar &
    lib::log '>>> waybar'
else
    lib::log '[WARNING] No bar'
fi

# CKB
if lib::exists ckb-next; then
    lib::log 'Initializing `ckb-next`'
    lib::log '<<< ckb-next'
    killall -q -u $USER ckb-next
    ckb-next -b &
    lib::log '>>> ckb-next'
fi

# Language IME
if lib::exists fcitx5; then
    lib::log '<<< fcitx5'
    lib::log 'Initializing `fcitx5`'
    fcitx5 -r &
    lib::log '>>> fcitx5'
fi
