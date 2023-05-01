#!/usr/bin/env bash

CURSORPOS_FIFO="$HOME/.cache/cursorpos"
tail -f "$CURSORPOS_FIFO" \
    | grep --line-buffered ".*" \
    | while read -r line; do
        cursorpos=( $(echo "$line" | base64 -d | tr -d ',') )
        echo "{\"x\": ${cursorpos[0]}, \"y\": ${cursorpos[1]}}"
    done
