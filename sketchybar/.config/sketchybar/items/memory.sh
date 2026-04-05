#!/bin/bash

memory_top=(
  label.font="$FONT:Semibold:7"
  label=MEM
  icon.drawing=off
  width=0
  padding_right=15
  y_offset=6
)

memory_percent=(
  label.font="$FONT:Heavy:12"
  label=MEM
  y_offset=-4
  padding_right=15
  width=55
  icon.drawing=off
  update_freq=5
  script="$PLUGIN_DIR/memory.sh"
)

sketchybar --add item memory.top right              \
           --set memory.top "${memory_top[@]}"       \
                                                     \
           --add item memory.percent right           \
           --set memory.percent "${memory_percent[@]}"
