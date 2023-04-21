#!/bin/sh

# Outputs all audio sinks in JSON, indicating which is the default sink
# E.g.
# [
#   {
#     "id": 0,
#     "name": "Navi 21/23 HDMI/DP Audio Controller Digital Stereo (HDMI)",
#     "is-default": "false"
#   },
#   {
#     "id": 1,
#     "name": "SteelSeries Arctis 7 Chat",
#     "is-default": "false"
#   },
#   {
#     "id": 2,
#     "name": "SteelSeries Arctis 7 Game",
#     "is-default": "false"
#   },
#   {
#     "id": 3,
#     "name": "Starship/Matisse HD Audio Controller Analog Stereo",
#     "is-default": "true"
#   }
# ]

DEFAULT_SINK=$(pactl get-default-sink)
pactl --format=json list sinks | jq '
    .[] | {
        "id": .index,
        "name": .description,
        "is_default": (if .name == "'$DEFAULT_SINK'" then "true" else "false" end)
    }' | jq -jcs .
