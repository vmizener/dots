#!/usr/bin/env bash
SCRIPTNAME=$(basename $0)
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
# shellcheck source=./lib.sh
source "$SCRIPTPATH/lib.sh"
TITLE="Sway: Window Picker"
IFS=$'\n'

header="Select window"
if [[ -n $fifo ]]; then
    str=$(cat $fifo)
    rm -rf $fifo
    window_id=$(echo -e "$str" | cut -f1 -d:)

    selection=$(
        echo -e "$str" |
        #fzf --header="$header" --no-info --delimiter=: --preview="kitty +kitten icat --clear --place 200x40@0x0 --transfer-mode file /tmp/sway-snapshot/{1}*"
        fzf --header="$header" --no-info --delimiter=: --preview="feh /tmp/sway-snapshot/{1}*"
    )

    id=$(echo $selection | cut -d ":" -f1)
    if [[ -z $id ]]; then
        exit
    fi

    swaymsg "[con_id=$id]" focus
    exit
else
    # Windows listed in sequence with
    #  - window ID
    #  - window app ID
    #  - window name
    #  - window urgency
    windows=($(lib::get_windows id app_id name urgent))
    str=""
    columns="${#header}"
    lines=0
    for ((i=0; i<"${#windows[@]}"; i=i+4,lines++)); do
        id="${windows[i]}"
        app_id="${windows[i+1]}"
        name="${windows[i+2]}"
        is_urgent="${windows[i+3]}"

        if [[ $app_id = "null" ]]; then
            app_id=""
        fi
        if [[ $name = "null" ]]; then
            name=""
        fi
        if [[ $is_urgent = "true" ]]; then
            urgent='*'
        else
            urgent=''
        fi
        building_string="$urgent$id:$app_id:$name"
        if [[ ${#building_string} -gt $columns ]]; then
            columns=${#building_string}
        fi
        str="$str$building_string\n" 
    done
    echo "$str"

    lines=$((lines+3))
    #columns=$((columns+3))
    columns=$((columns+50))
    if [[ columns -gt 100 ]]; then
        columns=100
    fi

    rm -Rf /tmp/sway-window-picker-*
    fifo=/tmp/sway-window-picker-$(date +%s)
    mkfifo $fifo
    fifo=$fifo foot \
        --app-id prompt \
        --title "${TITLE}" \
        -W "${columns}x${lines}" \
        -f 'monospace:size=12' \
        "${SCRIPTPATH}/${SCRIPTNAME}" &
    pid=$!
    echo -n "$str" > $fifo

    # Kill when focus is lost
    while kill -0 $pid 2&>/dev/null; do
        pattern="
            recurse(.nodes[]?) | 
            recurse(.floating_nodes[]?) | 
            select(.pid==${pid}) | 
            .focused
        "
        is_focused=$(swaymsg -t get_tree | jq -r "$pattern")
        if [[ $is_focused == 'false' ]]; then
            kill -9 $pid
        fi
        sleep 0.1
    done &
fi

