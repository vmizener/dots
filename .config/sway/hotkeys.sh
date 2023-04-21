#!/usr/bin/env bash
SCRIPTNAME=$(basename $0)
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
TITLE="Sway: Cheat Sheet"
SWAY_CONFIG="${SCRIPTPATH}/config"

if [[ -n $SR ]]; then
    # Run FZF and exit if `SR` is set
    cat "${SWAY_CONFIG}" |
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
    # Kill when focus is lost
    pid=$!
    while kill -0 $pid 2&>/dev/null; do
        pattern="
            recurse(.nodes[]?) | 
            recurse(.floating_nodes[]?) | 
            select(.pid==${pid}) | 
            .focused
        "
        is_focused=$(swaymsg -t get_tree | jq -r "$pattern")
        if [[ $is_focused == 'false' ]]; then
            kill -9 $pid
        fi
        sleep 0.1
    done &
fi
