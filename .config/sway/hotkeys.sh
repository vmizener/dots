#!/usr/bin/env bash
SCRIPTNAME=$(basename $0)
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
TITLE="Sway: Cheat Sheet"
HOTKEYS_TXT="${SCRIPTPATH}/hotkeys.txt"
if [[ -n $SR ]]; then
    # Run FZF and exit if `SR` is set
    cat "${HOTKEYS_TXT}" | grep '^[^\n#]' | fzf --no-info
    exit
else
    # Otherwise relaunch script in foot with `SR` exported
    WIDTH="$(( $(wc -L ${HOTKEYS_TXT} | cut -f1 -d' ')+5 ))"
    SR=true foot \
        --app-id prompt \
        --title "${TITLE}" \
        -W "${WIDTH}x10" \
        -f 'monospace:size=12' \
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
