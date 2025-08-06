#!/usr/bin/env bash

toggled=$(hyprctl clients | grep "special:music")
monitor=$(hyprctl activeworkspace | head -n 1 | sed -E 's/^workspace.*monitor (.*):/\1/')

if [[ -z $toggled ]]; then
    echo not toggled
    hyprctl dispatch focusmonitor HDMI-A-1
    hyprctl dispatch togglespecialworkspace music
    hyprctl dispatch exec -- firefox -P gedisu --new-window https://music.youtube.com/
    sleep 0.2
# elif [[ -z $monitor ]]; then
#     echo toggled but not active
#     hyprctl dispatch focusmonitor HDMI-A-1
#     hyprctl dispatch togglespecialworkspace music
else 
    echo toggled but active
    hyprctl dispatch focusmonitor HDMI-A-1
    hyprctl dispatch togglespecialworkspace music
    hyprctl dispatch focusmonitor "$monitor"
fi
