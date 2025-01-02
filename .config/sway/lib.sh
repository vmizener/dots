#!/usr/bin/env bash

lib::init() {
    LOGPATH="/tmp/sway-daemons.log"
    for var in "$@"; do
        case $var in
            --reset)
                [[ -f "$LOGPATH" ]] && rm -f "$LOGPATH"
                touch "$LOGPATH"
                chmod 664 "$LOGPATH"
            ;;
            -*|--*)
                echo "Unknown option $i"
                return 1
            ;;
        esac
    done

    PATH=.
    PATH=$PATH:${HOME}/.local/bin
    PATH=$PATH:${HOME}/.cargo/bin
    PATH=$PATH:${HOME}/go/bin
    PATH=$PATH:/usr/local/sbin
    PATH=$PATH:/usr/local/bin
    PATH=$PATH:/usr/sbin
    PATH=$PATH:/usr/bin
    PATH=$PATH:/sbin
    PATH=$PATH:/bin
}

lib::exists() {
    # Usage:
    #     lib::exists [cmd ...]
    #
    # Returns whether all the given commands are in PATH.
    # E.g.
    #   `lib::exists bash zsh` -> RC 0
    #   `lib::exists not-bash` -> RC 1

    for arg in "$@"; do
        if ! command -v "$arg" >/dev/null 2>&1; then
            return 1
        fi
    done
}

lib::log() {
    # Usage:
    #     [command-with-output] | lib::log [message]
    #
    # Writes messages to the log file
    # E.g. 

    [ -z "$LOGPATH" ] && lib::init
    if [[ -n "$1" ]]; then
        # Has argument; dump to logfile
        echo -e "[$(date '+%B %d %H:%M')] $1" >> $LOGPATH
    elif [[ ! -t 0 ]]; then
        # No arguments; directly log from STDIN
        while read line; do
            [[ -n "$1" ]] && echo -n "$1 "
            echo -e "$line" >> $LOGPATH
        done < "/dev/stdin"
    fi
}

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
        recurse(.floating_nodes[]?) |
        select(.type==\"con\"), select(.type==\"floating_con\") |
        select(.app_id != null or .name != null) |
        {$(echo "${args[@]}" | tr ' ' ',')} |
        $(echo "${args[@]}" | sed -E 's/([a-zA-Z_]+)/\.\1/g' | tr ' ' ',')
    "
}
