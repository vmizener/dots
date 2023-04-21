#!/bin/sh

function get_vol () {
    # Detect mute
    [[ $(pactl get-sink-mute @DEFAULT_SINK@ | cut -f2 -d' ') == 'yes' ]]
    MUTED=$?

    if (( $MUTED == 0 )); then
        echo "0%"
    else
        echo $(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}')
    fi
}

# Emit initial volume
get_vol

# Subscribe to changes
pactl subscribe \
    | grep --line-buffered "sink" \
    | while read -r _; do
        get_vol
    done
