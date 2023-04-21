#!/bin/sh

SCRIPTS=$HOME/.config/eww/scripts
SINK_IDS=( $($SCRIPTS/get_audio_sinks.sh | jq '.[] | .id') )
SINK_COUNT=$($SCRIPTS/get_audio_sinks.sh | jq 'length')
CURRENT_SINK_ID=$($SCRIPTS/get_audio_sinks.sh | jq '.[] | select(.is_default == "true").id')
CURRENT_SINK_IDX=$(( $(printf "%s\n" "${SINK_IDS[@]}" | grep -n "^${CURRENT_SINK_ID}$" | cut -f1 -d:)-1 ))
echo $CURRENT_SINK_IDX

if [[ "$1" == "up" ]]; then
    NEW_SINK_IDX=$(( ($CURRENT_SINK_IDX-1)%$SINK_COUNT ))
else
    NEW_SINK_IDX=$(( ($CURRENT_SINK_IDX+1)%$SINK_COUNT ))
fi
echo $NEW_SINK_IDX
$SCRIPTS/set_audio_default_sink.sh "${SINK_IDS[$NEW_SINK_IDX]}"
eww update json_audio-sinks="$($SCRIPTS/get_audio_sinks.sh)"
