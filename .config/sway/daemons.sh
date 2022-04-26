#!/usr/bin/env bash

# Gesture control
killall -q fusuma
fusuma -d

# Display manager
killall -q kanshi
kanshi &

# Notification manager
killall -q mako
mako &

