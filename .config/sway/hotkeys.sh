#!/usr/bin/env bash
SCRIPTNAME=$(basename $0)
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
HOTKEYS_TXT="${SCRIPTPATH}/hotkeys.txt"
if [[ -n $SR ]]; then
    # Run FZF and exit if `SR` is set
    cat "${HOTKEYS_TXT}" | grep '[^\n]' | fzf
    exit
else
    # Otherwise relaunch script in foot with `SR` exported
    WIDTH="$(( $(wc -L ${HOTKEYS_TXT} | cut -f1 -d' ')+3 ))"
    SR=true foot --app-id prompt \
        -W "${WIDTH}x10" \
        -f 'monospace:size=12' \
        "${SCRIPTPATH}/${SCRIPTNAME}" &
fi
