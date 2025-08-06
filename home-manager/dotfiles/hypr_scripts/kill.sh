#!/usr/bin/env bash

pid=$(hyprctl activewindow | grep "pid" | sed -r 's/.*pid: (.*)/\1/')
kill "$pid"
