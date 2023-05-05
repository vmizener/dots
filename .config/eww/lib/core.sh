#!/usr/bin/env bash

#
#   Power
#

function power::on_bat() {
    # Returns whether a battery is present
    #
    # If `-p` is provided as argument, echos "true" or "false"
    # Otherwise, an exit code is emitted
    [ -d /sys/class/power_supply/BAT0 ]
    rc=$?
    if [[ $1 == '-p' ]]; then
        [[ $rc == 0 ]] && echo "true" || echo "false"
    else
        return $rc
    fi
}

function power::get_status() {
    if power::on_bat; then
        # Values:  "unknown", "charging", "discharging", "not charging", "full"
        echo $(cat /sys/class/power_supply/BAT0/status | tr '[:upper:]' '[:lower:]')
    else
        echo "n/a"
    fi
}

function power::get_capacity() {
    if power::on_bat; then 
        # Values: 0 - 100 (percent)
        echo $(cat /sys/class/power_supply/BAT0/capacity)
    else
        echo "0"
    fi
}

function power::get_capacity_level() {
    # Values: "unknown", "critical", "low", "normal", "high", "full"
    if power::on_bat; then
        echo $(cat /sys/class/power_supply/BAT0/capacity_level | tr '[:upper:]' '[:lower:]')
    else
        echo "n/a"
    fi
}

#
#   Audio
#

function audio::get_vol() {
    # Detect mute
    [[ $(pactl get-sink-mute @DEFAULT_SINK@ | cut -f2 -d' ') == 'yes' ]]
    MUTED=$?
    if (( $MUTED == 0 )); then
        echo "0"
    else
        echo $(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | tr -d '%')
    fi
}

function audio::subscribe() {
    # Emit initial volume
    audio::get_vol

    # Subscribe to changes
    pactl subscribe |
        grep --line-buffered "sink" |
        while read -r _; do
            audio::get_vol
        done
}

function audio::get_sinks() {
    # Outputs all audio sinks in JSON, indicating which is the default sink
    # E.g.
    # [
    #   {
    #     "id": 0,
    #     "name": "Navi 21/23 HDMI/DP Audio Controller Digital Stereo (HDMI)",
    #     "is-default": "false"
    #   },
    #   {
    #     "id": 0,
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
}

function audio::set_default_sink() {
    # Set default sink and move all existing inputs to it
    SINK_ID="$1"
    INPUTS=( $(pactl list short sink-inputs | cut -f1) )
    pactl set-default-sink "$SINK_ID"
    for input in "${INPUTS[@]}"; do
        pactl move-sink-input "$input" "$SINK_ID"
    done
}

function audio::scroll_sinks() {
    SINK_IDS=( $(audio::get_sinks | jq '.[] | .id') )
    SINK_COUNT=$(audio::get_sinks | jq 'length')
    [[ "$SINK_COUNT" -le 0 ]] && return 0
    CURRENT_SINK_ID=$(audio::get_sinks | jq '.[] | select(.is_default == "true").id')
    CURRENT_SINK_IDX=$(( $(printf "%s\n" "${SINK_IDS[@]}" | grep -n "^${CURRENT_SINK_ID}$" | cut -f1 -d:)-1 ))
    if [[ "$1" == "up" ]]; then
        NEW_SINK_IDX=$(( ($CURRENT_SINK_IDX-1)%$SINK_COUNT ))
    else
        NEW_SINK_IDX=$(( ($CURRENT_SINK_IDX+1)%$SINK_COUNT ))
    fi
    audio::set_default_sink "${SINK_IDS[$NEW_SINK_IDX]}"
}

#
# EWW
#

function eww::popup() {
    # Open or close a popup window via EWW

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
}

function eww::grace_hover() {
    # Usage:
    #   grace_hover [VAR]
    #   grace_hoverlost [VAR] [GRACE] [CMD ...]
    #
    # Updates $VAR only if hover is still lost after $GRACE seconds
    #
    # E.g.
    #
    # :onhover "./run eww::grace_hover bool_topbar-right-hover"
    # :onhoverlost "./run eww::grace_hover_lost bool_topbar-right-hover 0.5"
    #
    # or
    #
    # :onhoverlost `./run eww::grace_hover_lost.sh bool_sidebar-visible 0.3 './scripts/run eww::popup close sidebar-visible'`

    VAR=$1
    LOCK_FILE="$HOME/.cache/eww-grace-$VAR.lock"
    if [[ -f "$LOCK_FILE" ]]; then
        rm -f "$LOCK_FILE"
    fi
    eww update "${VAR}=true"
}

function eww::grace_hover_lost() {
    # See `eww::grace_hover` for usage

    VAR=$1
    shift
    GRACE=$1
    shift
    LOCK_FILE="$HOME/.cache/eww-grace-$VAR.lock"
    (
        touch "$LOCK_FILE"
        sleep "$GRACE"
        if [[ -f "$LOCK_FILE" ]]; then
            rm -f "$LOCK_FILE"
            while (( "$#" > 0 )); do
                /usr/bin/env bash -c "$0"
                shift
            done
            eww update "${VAR}=false"
        fi
    ) &
}