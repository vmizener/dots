#!/usr/bin/env bash

# Clipboard manager
killall -q wl-paste
wl-paste -t text --watch clipman store &

# Clipboard sync (needs Julia on system path)
ps -ef | grep "[c]lipboard_sync" | tr -s ' ' | cut -d' ' -f2 | xargs kill
~/.config/sway/clipboard_sync.jl >/dev/null 2>&1 &

# Inhibit idle while playing audio or listening on mic
killall -q sway-audio-idle
sway-audio-idle-inhibit &

# Gesture control
killall -q fusuma
fusuma -d

# Display manager
killall -q kanshi
kanshi &

# Notification manager
killall -q mako
mako &

# Status bar
killall -q waybar
while pgrep -x waybar >/dev/null; do sleep 1; done
waybar &
