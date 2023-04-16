#!/usr/bin/env bash

lib::get_windows() {
    # Usage:
    #     lib::get_windows [property|property=val ...]
    #
    # Returns the specified details of all open windows in sequence.
    # E.g. `lib::get_windows id app_id` will return:
    #     <window 1 id>
    #     <window 1 app_id>
    #     <window 2 id>
    #     <window 2 app_id>
    #     ...
    #
    # If an equality is given, the detail is treated as a filter.
    # E.g.  `lib::get_windows id name=kitty app_id` will return:
    #     <kitty 1 id>
    #     <kitty 1 app_id>
    #     <kitty 2 id>
    #     <kitty 2 app_id>
    #
    # Available properties can be listed by running:
    #     swaymsg -t get_tree | jq -r 'recurse(.nodes[]?)|select(.type=="con"),select(.type=="floating_con")'|jq -rs '.[0]|keys'

    args=($(echo "$@" | tr ' ' $'\n' | grep -v '='))
    filters=($(echo "$@" | tr ' ' $'\n' | grep '='))

    if [ ${#args} -eq 0 ]; then
        return 0
    fi

    swaymsg -t get_tree | jq -r "
        recurse(.nodes[]?) |
        select(.type==\"con\"), select(.type==\"floating_con\") |
        select(.app_id != null or .name != null) |
        {$(echo "${args[@]}" | tr ' ' ',')} |
        $(echo "${args[@]}" | sed -E 's/([a-zA-Z_]+)/\.\1/g' | tr ' ' ',')
    "
}

lib::get_windows "$@"
