#!/bin/bash

source "$HOME/.config/sketchybar/colors.sh"

WIFI_STATUS=$(ifconfig en0 2>/dev/null | grep "status:" | awk '{print $2}')

if [ "$WIFI_STATUS" = "active" ]; then
  sketchybar --set wifi icon=󰤨 label="Connected" label.color=$WHITE
else
  sketchybar --set wifi icon=󰤭 label="Offline" label.color=$RED
fi
