#!/bin/bash

wifi=(
  icon=󰤨
  icon.font="$ICON_FONT:Regular:17.0"
  label.font="$FONT:Semibold:11.0"
  padding_right=7
  label.padding_right=5
  update_freq=30
  script="$PLUGIN_DIR/wifi.sh"
)

sketchybar --add item wifi right          \
           --set wifi "${wifi[@]}"         \
           --subscribe wifi wifi_change
