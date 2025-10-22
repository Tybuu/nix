#!/usr/bin/env bash

focused=$(niri msg --json workspaces | jq -r '.[]| select(.name == "music") | if .is_active then 1 else 0 end')
toggled=$(niri msg --json workspaces | jq -r '.[]| select(.name == "music") | if .active_window_id then 1 else 0 end')
current_mon=$(niri msg --json workspaces | jq -r '.[]| select(.is_focused == true) | .output')


if ((toggled)); then 
  if (( focused )); then
    echo 'Focused'
    niri msg action focus-workspace "burner"
    niri msg action focus-monitor "$current_mon"
  else
    echo 'Not focused'
    niri msg action focus-workspace "music"
    niri msg action focus-monitor "$current_mon"
  fi
else
  niri msg action focus-workspace "music"
  niri msg action spawn-sh -- "firefox -P gedisu --new-window https://music.youtube.com/"
fi
