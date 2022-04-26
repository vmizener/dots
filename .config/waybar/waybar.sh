#!/usr/bin/env sh

# Terminate any running bar instances
killall -q waybar

# Wait until the processes have finished shutting down
while pgrep -x waybar >/dev/null; do sleep 1; done

# Launch
waybar
