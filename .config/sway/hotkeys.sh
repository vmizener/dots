#!/usr/bin/env bash

cat ~/.config/sway/hotkeys.txt | grep '[^\n]' | wofi -Ii --show=dmenu >/dev/null
