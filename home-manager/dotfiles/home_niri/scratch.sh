#!/usr/bin/env bash

focused=$(niri msg --json workspaces | jq -r '.[]| select(.name == "scratch") | if .is_active then 1 else 0 end')
toggled=$(niri msg --json workspaces | jq -r '.[]| select(.name == "scratch") | if .active_window_id then 1 else 0 end')
current_mon=$(niri msg --json workspaces | jq -r '.[]| select(.is_focused == true) | .output')


if ((toggled)); then 
  if (( focused )); then
    niri msg action focus-workspace "burner"
    niri msg action focus-monitor "$current_mon"
  else
    niri msg action focus-workspace "scratch"
    niri msg action focus-monitor "$current_mon"
  fi
else
  niri msg action focus-workspace "scratch"
  niri msg action spawn-sh -- "google-chrome-stable"
  niri msg action spawn-sh -- "foot"
fi
