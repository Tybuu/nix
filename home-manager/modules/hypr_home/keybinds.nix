{
  pkgs,
  lib,
  config,
  hostName,
  ...
}: {
  wayland.windowManager.hyprland = {
    settings = {
      "$mainMod" = "SUPER";
      "$terminal" = "foot";
      "$fileManager" = "nautilus";
      "$browser" = "firefox";
      "$menu" = "wofi --show drun";

      bind =
        [
          "$mainMod, T, exec, $terminal"
          "$mainMod, F, exec, $fileManager"
          "$mainMod, E, exec, $menu"
          "$mainMod, B, exec, $browser"
          "$mainMod, W, exec, pkill waybar || waybar"
          "$mainMod SHIFT, S, exec, hyprshot -m region"

          # Window Manipulation
          "$mainMod, C, killactive,"
          "$mainMod SHIFT, C, exec, ~/.config/hypr/scripts/kill.sh"
          "$mainMod, V, togglefloating,"
          "$mainMod, S, togglesplit," # dwindle
          "$mainMod, M, fullscreen, 1"
          "$mainMod SHIFT, f, fullscreenstate, -1 2"
          "$mainMod SHIFT, M, fullscreen, 0"

          # Focus Movement
          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"

          # Window Movement
          "$mainMod SHIFT, left, movewindow, l"
          "$mainMod SHIFT, right, movewindow, r"
          "$mainMod SHIFT, up, movewindow, u"
          "$mainMod SHIFT, down, movewindow, d"

          # Scroll through existing workspaces with mainMod + scroll
          "$mainMod, mouse_down, split:workspace, e+1"
          "$mainMod, mouse_up, split:workspace, e-1"

          # Brightness controls (relying on 'brightnessctl' in PATH)
        ]
        ++ lib.flatten (builtins.genList (
            i: let
              key =
                if i == 9
                then "0"
                else toString (i + 1);
              ws = toString (i + 1);
            in [
              "$mainMod, ${key}, split:workspace, ${ws}"
              "$mainMod SHIFT,${key}, split:movetoworkspace, ${ws}"
            ]
          )
          10)
        ++ lib.optionals (hostName == "tymid") [
          # Switching monitors
          "$mainMod, comma, focusmonitor, DP-1"
          "$mainMod, period, focusmonitor, DP-2"
          "$mainMod, slash, focusmonitor, HDMI-A-1"

          "$mainMod SHIFT, comma, movewindow, mon:DP-1"
          "$mainMod SHIFT, period, movewindow, mon:DP-2"
          "$mainMod SHIFT, slash, movewindow, mon:HDMI-A-1"

          # Specific binds for tymid
          "$mainMod, Z, exec, hyprctl clients | grep \"moonlight\" || [workspace special:gaming silent] moonlight stream tybeast Desktop --1440 --game-optimization --bitrate 69000 --fps 180 --no-hdr"
          "$mainMod, R, exec, ~/.config/hypr/scripts/music.sh"

          # Toggles display on DP-2
          "$mainMod, D, exec, echo -ne '\x01' | socat - UNIX-SENDTO:/tmp/stream_temp"
        ]
        ++ lib.optionals (hostName == "tyoga") [
          # Switching Monitors
          "$mainMod, comma, focusmonitor, eDP-1"
          "$mainMod, period, focusmonitor, DP-1"

          "$mainMod SHIFT, comma, movewindow, mon:eDP-1"
          "$mainMod SHIFT, period, movewindow, mon:DP-1"

          "$mainMod, h, movefocus, l"
          "$mainMod, l, movefocus, r"
          "$mainMod, k, movefocus, u"
          "$mainMod, j, movefocus, d"
          "$mainMod SHIFT, h, movewindow, l"
          "$mainMod SHIFT, l, movewindow, r"
          "$mainMod SHIFT, k, movewindow, u"
          "$mainMod SHIFT, j, movewindow, d"

          "$mainMod, U, exec, brightnessctl s 5%+"
          "$mainMod, D, exec, brightnessctl s 5%-"
        ];

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      # Laptop multimedia keys for volume (relying on 'wpctl' in PATH)
      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ];

      # Media keys (relying on 'playerctl' in PATH)
      bindl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];
    };
  };
}
