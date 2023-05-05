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

function workspace::focus_subscriber() {
    workspace::list_by_output
    swaymsg -t subscribe -m '["workspace"]' | jq --unbuffered -rc '.change' |
        while read -r event; do
            if ! ( [ "$event" = "focus" ] || [ "$event" = "move" ] ); then
                continue
            fi
            workspace::list_by_output
        done
}

function container::snapshot_subscriber() {
    SNAPSHOT_DIR="${HOME}/.cache/eww-snapshots"
    mkdir -p "$SNAPSHOT_DIR"
    rm -f "$SNAPSHOT_DIR"/*.jpg
    swaymsg -t subscribe -m '["window"]' |
        jq --unbuffered -rc '[
            .change,
            .container.id,
            .container.pid,
            .container.rect.x,
            .container.rect.y,
            .container.rect.width,
            .container.rect.height
        ] | @tsv' |
        while read -r line; do
            line=( $(echo "$line") )
            event="${line[1]}"
            if [ "$event" = "focus" ] || [ "$event" = "new" ]; then
                window="window-${line[2]}-${line[3]}.jpg"
                rect_x="${line[4]}"
                rect_y="${line[5]}"
                rect_w="${line[6]}"
                rect_h="${line[7]}"
                grim -g "${rect_x},${rect_y} ${rect_w}x${rect_h}" "$SNAPSHOT_DIR/$window"
            elif [ "$event" = "close" ]; then
                rm -f "$SNAPSHOT_DIR/$window"
            fi
    done

}

function container::list_container_snapshots() {
    SNAPSHOT_DIR="${HOME}/.cache/eww-snapshots"
    echo $(ls "${SNAPSHOT_DIR}"/*.jpg | jq -R | jq -cs)
}
