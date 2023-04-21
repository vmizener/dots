#!/usr/bin/env bash

DIM_BRIGHTNESS=10   # Dim to 10% brightness

TIMEOUT_DIM=120     #  2 min:   Dim screen if on battery
TIMEOUT_LOCK=600    # 10 min:   Lock if on battery
TIMEOUT_BLACK=900   # 15 min:   Turn off screen

# Turn off screen after 30 seconds when locked
TIMEOUT_LOCKED_BLACK=30

# Use tmp files to store state as envvars don't work
TMP_SCREENBRIGHTNESS=/tmp/swayidle_screenbrightness
if [ ! -f "$TMP_SCREENBRIGHTNESS" ]; then
    touch "$TMP_SCREENBRIGHTNESS"
fi

function on_battery() {
    AC_STATUS=/sys/class/power_supply/AC/online
    [ -f "$AC_STATUS" ] && [ $(cat "$AC_STATUS") -eq 0 ]
}

killall -q swayidle
swayidle -w \
    timeout $TIMEOUT_DIM \
        "echo \$(brightnessctl -c backlight g) > $TMP_SCREENBRIGHTNESS; if on_battery; then brightnessctl -c backlight s $DIM_BRIGHTNESS; fi" \
        resume "brightnessctl s \$(cat $TMP_SCREENBRIGHTNESS)" \
    timeout $TIMEOUT_LOCK \
        "if on_battery; then swaylock; fi" \
    timeout $TIMEOUT_BLACK \
        'swaymsg "output * dpms off"' \
        resume 'swaymsg "output * dpms on"' \
    timeout $TIMEOUT_LOCKED_BLACK \
        'if pgrep swaylock; then swaymsg "output * dpms off"; fi' \
        resume 'if pgrep swaylock; then swaymsg "output * dpms on"; fi' \
    before-sleep \
        'swaylock' \
    before-sleep \
        'playerctl -a pause'

