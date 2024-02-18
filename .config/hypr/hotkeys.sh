#!/usr/bin/env bash
SCRIPTNAME=$(basename $0)
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
TITLE="Hyprland: Cheat Sheet"
HYPR_CONFIG="${SCRIPTPATH}/hyprland.conf"

if [[ -n $SR ]]; then
    # Run FZF and exit if `SR` is set
    cat "${HYPR_CONFIG}" |
        grep -E '#\?' |
        sed -n 's/^\s\+#? \(\[\w\+\] \)\?\([][0-9A-Za-z+`?<>;]\+\).\+| \(.*\)$/\1\2🗲\3/p' |
        column -t -s '🗲' |
        fzf --no-info
    exit
else
    # Otherwise relaunch script in foot with `SR` exported
    SR=true foot \
        --app-id prompt \
        --title "${TITLE}" \
        -W "200x20" \
        -f 'monospace:size=10' \
        "${SCRIPTPATH}/${SCRIPTNAME}" &
    sleep 1
    # Kill when focus is lost
    pid=$!
    while kill -0 $pid 2&>/dev/null; do
        focused_pid=$(hyprctl clients -j | jq -r '.[] | select(.focusHistoryID == 0).pid')
        echo "$focused_pid $pid"
        if [[ "$focused_pid" != "$pid" ]]; then
            kill -9 $pid
        fi
        sleep 0.1
    done
fi
