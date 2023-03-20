#!/usr/bin/env bash
SCRIPTNAME=$(basename $0)
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
TITLE="Sway: Window Picker"
IFS=$'\n'

header="Select window"
if [[ -n $fifo ]]; then
    str=$(cat $fifo)
    rm -rf $fifo

    selection=$(printf $str | fzf --header=$header --no-info)

    id=$(echo $selection | cut -d ":" -f1)
    if [[ -z $id ]]; then
        exit
    fi

    swaymsg "[con_id=$id]" focus
    exit
else
    windows=(
        $(swaymsg -t get_tree | jq -r '
            recurse(.nodes[]?) | 
            recurse(.floating_nodes[]?) | 
            select(.type=="con"), select(.type=="floating_con") | 
            select(.app_id != null or .name != null) | 
            {id, app_id, name} | .id, .app_id, .name
        ')
    )

    str=""
    columns="${#header}"
    lines=0
    for ((i=0; i<"${#windows[@]}"; i=i+3,lines++)); do
        id="${windows[i]}"
        app_id="${windows[i+1]}"
        name="${windows[i+2]}"

        if [[ $app_id = "null" ]]; then
            app_id=""
        fi
        if [[ $name = "null" ]]; then
            name=""
        fi
        building_string="$id:$app_id:$name"
        if [[ ${#building_string} -gt $columns ]]; then
            columns=${#building_string}
        fi
        str="$str$building_string\n" 
    done
    echo $str

    lines=$((lines+3))
    columns=$((columns+3))
    if [[ columns -gt 100 ]]; then
        columns=100
    fi

    fifo=/tmp/sts-$(date +%s)
    mkfifo $fifo
    fifo=$fifo foot \
        --app-id prompt \
        --title "${TITLE}" \
        -W "${columns}x${lines}" \
        -f 'monospace:size=12' \
        "${SCRIPTPATH}/${SCRIPTNAME}" &
    pid=$!
    echo -n $str > $fifo

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

