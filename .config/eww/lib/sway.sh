#!/usr/bin/env bash

function workspace::focus() {
    swaymsg workspace "$1" >/dev/null
}

function workspace::list_by_output() {
    echo $(swaymsg -t get_workspaces |
        jq '.[] | {focused, output, name}' |
        jq -jcs 'group_by(.output)'
    )
}

function workspace::subscribe() {
    workspace::list_by_output
    swaymsg -t subscribe -m '["workspace"]' | jq --unbuffered -rc '.change' |
        while read -r event; do
            if ! ( [ "$event" = "focus" ] || [ "$event" = "move" ] ); then
                continue
            fi
            workspace::list_by_output
        done
}
