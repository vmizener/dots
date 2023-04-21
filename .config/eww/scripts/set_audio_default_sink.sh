#!/bin/sh

# Set default sink and move all existing inputs to it

SINK_ID="$1"
INPUTS=( $(pactl list short sink-inputs | cut -f1) )
pactl set-default-sink "$SINK_ID"
for input in "${INPUTS[@]}"; do
    pactl move-sink-input "$input" "$SINK_ID"
done
