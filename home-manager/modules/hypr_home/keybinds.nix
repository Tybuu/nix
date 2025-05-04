{
  pkgs,
  lib,
  ...
}: let
  hostName = builtins.getEnv "HOSTNAME";
  gameYes = hostName == "tymid";
in {
  wayland.windowManager.hyprland = {
    settings = {
      "$mainMod" = "SUPER";
      "$terminal" = "foot";
      "$fileManager" = "nautilus";
      "$browser" = "firefox";
      "$menu" = "wofi --show drun";

      bind = [
        "$mainMod, T, exec, $terminal"
        "$mainMod, F, exec, $fileManager"
        "$mainMod, R, exec, $menu"
        "$mainMod, B, exec, $browser"
        # Relying on 'firefox' being in PATH and configured profile 'gedisu'
        "$mainMod SHIFT, B, exec, firefox -P gedisu --new-window https://music.youtube.com/"
        # Relying on 'moonlight' being in PATH
        # Relying on 'pkill' and 'waybar' being in PATH
        "$mainMod, W, exec, pkill waybar || waybar"

        # Window Manipulation
        "$mainMod, C, killactive,"
        "$mainMod SHIFT, C, exec, ~/.config/hypr/kill.sh"
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

        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Example special workspace (scratchpad)
        "$mainMod, E, togglespecialworkspace, music"
        "$mainMod SHIFT, E, movetoworkspace, special:music"

        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

        # Brightness controls (relying on 'brightnessctl' in PATH)
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
