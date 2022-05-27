#!/usr/bin/env bash

TIMEOUT_DIM=120     #  2 min:   Dim screen if on battery
TIMEOUT_LOCK=600    # 10 min:   Lock (must be before turning off screen)
TIMEOUT_BLACK=900   # 15 min:   Turn off screen

DIM_BRIGHTNESS=10   # Dim to 10% brightness

# Use tmp files to store state as envvars don't work
TMP_SCREENBRIGHTNESS=/tmp/swayidle_screenbrightness
if [ ! -f "$TMP_SCREENBRIGHTNESS" ]; then
    touch "$TMP_SCREENBRIGHTNESS"
fi

AC_STATUS=/sys/class/power_supply/AC/online

killall -q swayidle
swayidle -w \
    timeout $TIMEOUT_DIM \
        "echo \$(brightnessctl g) > $TMP_SCREENBRIGHTNESS; if [ \$(cat $AC_STATUS) -eq 0 ]; then brightnessctl s $DIM_BRIGHTNESS; fi" \
        resume "brightnessctl s \$(cat $TMP_SCREENBRIGHTNESS)" \
    timeout $TIMEOUT_LOCK \
        'swaylock' \
    timeout $TIMEOUT_BLACK \
        'swaymsg "output * dpms off"' \
        resume 'swaymsg "output * dpms on"' \
    before-sleep \
        'swaylock' \
    before-sleep \
        'playerctl -a pause'

