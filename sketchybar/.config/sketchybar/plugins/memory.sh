#!/bin/bash

# Get memory pressure/usage on macOS
MEMORY_PRESSURE=$(memory_pressure | grep "System-wide memory free percentage:" | awk '{print $5}' | tr -d '%')
MEMORY_USED=$((100 - MEMORY_PRESSURE))

COLOR=$WHITE
if [ "$MEMORY_USED" -gt 80 ]; then
  COLOR=$RED
elif [ "$MEMORY_USED" -gt 60 ]; then
  COLOR=$YELLOW
fi

sketchybar --set memory.percent label="${MEMORY_USED}%" \
                                label.color=$COLOR
