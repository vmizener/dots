#!/bin/sh

function window () {
    [[ $1 == 'open' ]]
    OPEN=$?
    WINDOW=$2
    LOCK_FILE="$HOME/.cache/eww-$WINDOW.lock"

    if (( $OPEN == 0 )) && [[ ! -f "$LOCK_FILE" ]]; then
        touch "$LOCK_FILE"
        eww open $WINDOW
    elif (( $OPEN != 0 )) && [[ -f "$LOCK_FILE" ]]; then
        rm "$LOCK_FILE"
        eww close $WINDOW
    fi
}

if [[ ! $(pidof eww) ]]; then
    eww daemon
    sleep 1
fi
window $1 $2
