#!/usr/bin/env bash

tag_number=20
output_name="HDMI-A-2"
monitor=$(river-bedload -print outputs | jq -r '.[] | select(.focused == true) | .name')
toggled_output=$(river-bedload -print outputs | jq -r '.[] | select(.name == "'$output_name'") | .view_tags')
toggled=$(( (toggled_output & (1 << tag_number)) != 0 ))
focused_output=$(river-bedload -print outputs | jq -r '.[] | select(.name == "'$output_name'") | .focused_tags')
focused=$(( (focused_output & (1 << tag_number)) != 0 ))

echo $monitor
echo $toggled_output
echo $toggled
echo $focused_output
echo $focused


if (( toggled )); then
  if (( focused )); then 
    echo focused
    riverctl focus-output $output_name
    riverctl set-focused-tags 1
    riverctl focus-output $monitor
  else
    echo not focused
    riverctl focus-output $output_name 
    riverctl set-focused-tags $(( 1 << tag_number ))
    riverctl focus-output $monitor
  fi
else
  riverctl focus-output $output_name 
  riverctl set-focused-tags $(( 1 << tag_number ))
  riverctl spawn "firefox -P gedisu --new-window https://music.youtube.com/"
fi
