#!/usr/bin/env bash

tag_number=20
monitor=$(river-bedload -print outputs | jq -r '.[] | select(.focused == true) | .name')
toggled_output=$(river-bedload -print outputs | jq -r '.[] | select(.name == "DP-2") | .view_tags')
toggled=$(( (toggled_output & (1 << tag_number)) != 0 ))
focused_output=$(river-bedload -print outputs | jq -r '.[] | select(.name == "DP-2") | .focused_tags')
focused=$(( (focused_output & (1 << tag_number)) != 0 ))

echo $monitor
echo $toggled_output
echo $toggled
echo $focused_output
echo $focused


if (( toggled )); then
  if (( focused )); then 
    riverctl focus-output "DP-2" 
    riverctl set-focused-tags 1
    riverctl focus-output $monitor
  else
    riverctl focus-output "DP-2" 
    riverctl set-focused-tags $(( 1 << tag_number ))
  fi
else
  riverctl spawn "moonlight stream tybeast Desktop --1440 --game-optimization --bitrate 69000 --fps 180 --no-hdr"
fi
