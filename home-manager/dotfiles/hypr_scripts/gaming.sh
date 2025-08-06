toggled=$(hyprctl clients | grep "Moonlight")

if [[ -z $toggled ]]; then
  echo toggled
    hyprctl dispatch exec -- moonlight stream tybeast Desktop --1440 --game-optimization --bitrate 69000 --fps 180 --no-hdr
fi
