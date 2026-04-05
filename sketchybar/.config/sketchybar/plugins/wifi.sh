#!/bin/bash

source "$HOME/.config/sketchybar/colors.sh"

WIFI=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I)
SSID=$(echo "$WIFI" | grep -o "SSID: .*" | sed 's/^SSID: //')

if [ "$SSID" = "" ]; then
  sketchybar --set wifi icon=󰤭 label="Offline" label.color=$RED
else
  sketchybar --set wifi icon=󰤨 label="$SSID" label.color=$WHITE
fi
