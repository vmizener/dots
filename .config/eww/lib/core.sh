#!/usr/bin/env bash

#
#   Network
#

function network::get_active_connections() {
    default_interface=$(ip -o route get 8.8.8.8 | rg 'dev ([^ ]*)' -or '$1')
    declare -a ret
    while IFS= read -r entry; do
        IFS=':' read -a arr <<< "$entry"
        c_type="${arr[0]}"
        c_device="${arr[1]}"
        c_state="${arr[2]}"
        c_conn="${arr[3]}"
        is_default=$([[ "${c_device}" == "${default_interface}" ]] && echo 'true' || echo 'false')
        [[ ! "${c_state}" = "connected" ]] && continue
        strength=100
        if [[ "${c_type}" == "wifi" ]]; then
            strength=$(network::list_wifi | jq -r ".[] | select(.ssid == \"${c_conn}\") | .best_signal")
        fi
        ret+=("{\"name\": \"${c_conn}\", \"device\": \"${c_device}\", \"type\": \"${c_type}\", \"is_default\": \"${is_default}\", \"strength\": \"${strength}\"}")
    done < <(nmcli -t -f TYPE,DEVICE,STATE,CONNECTION device | grep -v '^loopback:')
    echo "${ret[@]}" | jq -cs
}

function network::is_wifi_enabled() {
    # Returns whether wifi is enabled
    #
    # If `-p` is provided as argument, echos "true" or "false"
    # Otherwise, an exit code is emitted
    [[ $(nmcli radio wifi) = 'enabled' ]]; rc=$?
    if [[ $1 == '-p' ]]; then
        [[ $rc == 0 ]] && echo "true" || echo "false"
    else
        return $rc
    fi
}

function network::list_wifi() {
    declare -a ret
    while IFS= read -r entry; do
        IFS=':' read -a arr <<< "$entry"
        c_in_use=$([[ "${arr[0]}" = " " ]] && echo 'false' || echo 'true')
        c_bssid="${arr[1]}"
        c_ssid="${arr[2]}"
        c_mode="${arr[3]}"
        c_chan="${arr[4]}"
        c_rate="${arr[5]}"
        c_signal="${arr[6]}"
        c_bars="${arr[7]}"
        c_security=$([[ "${arr[8]}" = "" ]] && echo 'None' || echo "${arr[8]}")
        ret+=( """{
            \"in_use\": ${c_in_use},
            \"bssid\": \"${c_bssid}\",
            \"ssid\": \"${c_ssid}\",
            \"mode\": \"${c_mode}\",
            \"chan\": \"${c_chan}\",
            \"rate\": \"${c_rate}\",
            \"signal\": \"${c_signal}\",
            \"bars\": \"${c_bars}\",
            \"security\": \"${c_security}\"
        }""")
    done < <(nmcli -t device wifi list)
    echo "${ret[@]}" | jq 'select(.ssid != "")' | jq -s """[
        group_by(.ssid)[] | sort_by(.signal) | reverse | {
            ssid: .[0].ssid,
            in_use: ([.[] | .in_use] | any),
            mode: .[0].mode,
            security: .[0].security,
            best_signal: ([.[] | .signal] | max),
            best_bars: ([.[] | [.signal, .bars]] | max | .[1]),
            details: [.[] | {
                bssid: .bssid,
                chan: .chan,
                rate: .rate,
                signal: .signal,
                bars: .bars
            }]
        }
    ]"""
}

#
#   Power
#

function power::on_bat() {
    # Returns whether a battery is present
    #
    # If `-p` is provided as argument, echos "true" or "false"
    # Otherwise, an exit code is emitted
    [ -d /sys/class/power_supply/BAT0 ]; rc=$?
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

function audio::get_status() {
    sink="$(pactl get-default-sink)"
    # Detect mute
    [[ $(pactl get-sink-mute @DEFAULT_SINK@ | cut -f2 -d' ') == 'yes' ]]
    is_muted=$?
    if (( $is_muted == 0 )); then
        vol="0"
    else
        vol="$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | tr -d '%')"
    fi
    sink_json="$(pactl --format=json list sinks | jq '.[] | select(.name=="'$sink'")')"
    desc=$(echo "$sink_json" | jq -r '.description')
    form_factor=$(echo "$sink_json" | jq -r '.properties."device.form_factor"')
    [[ "$form_factor" =~ "null" ]] && form_factor="default"
    echo '{
        "vol": '$vol',
        "desc": "'$desc'",
        "type": "'$form_factor'",
        "sink": "'$sink'"
    }' | jq -c
}

function audio::subscribe() {
    # Emit initial status
    audio::get_status

    # Subscribe to changes
    pactl subscribe |
        grep --line-buffered "sink" |
        while read -r _; do
            audio::get_status
        done
}

function audio::get_sinks() {
    # Outputs all audio sinks in JSON, indicating which is the default sink
    # E.g.
    # [
    #   {
    #     "id": 0,
    #     "name": "Navi 21/23 HDMI/DP Audio Controller Digital Stereo (HDMI)",
    #     "is-default": "false",
    #     "type": null
    #   },
    #   {
    #     "id": 1,
    #     "name": "SteelSeries Arctis 7 Chat",
    #     "is-default": "false",
    #     "type": "headset"
    #   },
    #   {
    #     "id": 2,
    #     "name": "SteelSeries Arctis 7 Game",
    #     "is-default": "false",
    #     "type": "headset"
    #   },
    #   {
    #     "id": 3,
    #     "name": "Starship/Matisse HD Audio Controller Analog Stereo",
    #     "is-default": "true",
    #     "type": null
    #   }
    # ]

    DEFAULT_SINK=$(pactl get-default-sink)
    pactl --format=json list sinks | jq '
        .[] | {
            "id": .index,
            "name": .description,
            "is_default": (if .name == "'$DEFAULT_SINK'" then "true" else "false" end),
            "type": .properties."device.form_factor"
        }' | jq -jcs 'sort_by(.name)'
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
# Weather
#

function weather::status() {
    local SYMBOLS='{
        "Unknown":             "✨",
        "Clear":               "☀️",
        "Cloudy":              "☁️",
        "Fog":                 "🌫",
        "HeavyRain":           "🌧",
        "HeavyShowers":        "🌧",
        "HeavySnow":           "❄️",
        "HeavySnowShowers":    "❄️",
        "LightRain":           "🌦",
        "LightShowers":        "🌦",
        "LightSleet":          "🌧",
        "LightSleetShowers":   "🌧",
        "LightSnow":           "🌨",
        "LightSnowShowers":    "🌨",
        "Overcast":            "☁️",
        "PartlyCloudy":        "⛅️",
        "Sunny":               "☀️",
        "ThunderyHeavyRain":   "🌩",
        "ThunderyShowers":     "⛈",
        "ThunderySnowShowers": "⛈",
        "VeryCloudy": "☁️"
    }'
    local URL="v2d.wttr.in/?format=j1"
    o=$(curl -m 10 ${URL} 2>/dev/null)
    # Handle when the service is down
    if [[ "$o" =~ "Unknown location" ]]; then
        >&2 echo "[ERR] weather::status\n$o"
        echo "{}"
        return 1
    fi
    o_FeelsLikeC=$(echo "$o" | jq -r '.current_condition[0].FeelsLikeC')
    o_FeelsLikeF=$(echo "$o" | jq -r '.current_condition[0].FeelsLikeF')
    o_TempC=$(echo "$o" | jq -r '.current_condition[0].temp_C')
    o_TempF=$(echo "$o" | jq -r '.current_condition[0].temp_F')
    o_Loc="$(echo "$o" | jq -r '.nearest_area[0].areaName[0].value'), $(echo "$o" | jq -r '.nearest_area[0].region[0].value')"
    o_weatherDesc="$(echo "$o" | jq -r '.current_condition[0].weatherDesc[0].value' | sed 's/\([[:blank:]][[:lower:]]\)/\U\1/g')"
    o_weatherIco=$(echo "$SYMBOLS" | jq -r ".$(echo "$o_weatherDesc" | sed 's/[[:blank:]]\(.\)/\1/g')")
    echo '{
        "FeelsLikeC": "'$o_FeelsLikeC'",
        "FeelsLikeF": "'$o_FeelsLikeF'",
        "TempC": "'$o_TempC'",
        "TempF": "'$o_TempF'",
        "Loc": "'$o_Loc'",
        "Desc": "'$o_weatherDesc'",
        "Icon": "'$o_weatherIco'"
    }' | jq -c
}

#
# EWW
#

function eww::popup() {
    # Open or close a popup window via EWW
    # Window should have an associated variable "bool_$WINDOW-visible" indicating if it should be visible

    function window () {
        [[ $1 == 'open' ]]
        OPEN=$?
        WINDOW=$2
        DELAY=$3
        LOCK_FILE="$HOME/.cache/eww-$WINDOW.lock"
        VIS_BOOL="bool_$WINDOW-visible"

        # Update VIS_BOOL before delay on CLOSE, but after on OPEN to let transitions draw
        if (( $OPEN != 0 )); then
            eww update "$VIS_BOOL=false"
        fi
        # Parse and run delay if provided
        if [ -n "$DELAY" ]; then
            DELAY=$(echo "$DELAY" | tr -d '[:alpha:]')
            DELAY=$(echo "scale=2 ; ${DELAY}/1000" | bc)
            sleep "$DELAY"
        fi
        if (( $OPEN == 0 )) && [[ ! -f "$LOCK_FILE" ]]; then
            touch "$LOCK_FILE"
            eww open $WINDOW
        elif (( $OPEN != 0 )) && [[ -f "$LOCK_FILE" ]] && [[ $(eww get $VIS_BOOL) = "false" ]]; then
            # Only close if VIS_BOOL is still false
            rm "$LOCK_FILE"
            eww close $WINDOW
        fi
        if (( $OPEN == 0 )); then
            eww update "$VIS_BOOL=true"
        fi
    }
    if [[ ! $(timeout 1s pidof eww) ]]; then
        eww daemon
        sleep 1
    fi
    window $1 $2 $3 &
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
