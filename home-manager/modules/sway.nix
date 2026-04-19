{
  lib,
  hostName,
  ...
}: {
  wayland.windowManager.sway = {
    enable = true;
    extraOptions = [
      "--unsupported-gpu"
    ];
    config = rec {
      modifier = "Mod4";
      terminal = "foot";
      menu = "wofi --show drun";
      bars = [];
      startup = [
        {command = "autotiling-rs";}
      ];
      output = let
        wallpaper = ../wallpaper.png;
      in
        if hostName == "tybeast"
        then {
          DP-2 = {
            res = "1920x1080@144hz";
            position = "0,0";
            transform = "270";
            bg = "${wallpaper} fill";
          };
          DP-1 = {
            res = "2560x1440@180hz";
            position = "1080,0";
            bg = "${wallpaper} fill";
          };
          HDMI-A-2 = {
            res = "1920x1080";
            position = "3640,0";
            bg = "${wallpaper} fill";
          };
        }
        else {};
      input = {
        "*" = {
          accel_profile = "flat";
          pointer_accel = "0";
        };
      };
      keybindings = let
        browser = "firefox";
      in
        {
          "${modifier}+t" = "exec ${terminal}";
          "${modifier}+e" = "exec ${menu}";
          "${modifier}+b" = "exec ${browser}";

          "${modifier}+c" = "kill";
          "${modifier}+Shift+S" = "exec 'hyprshot -m region'";
          "${modifier}+g" = "bar mode toggle";
          "${modifier}+f" = "fullscreen";
          "${modifier}+space" = "floating toggle";

          "XF86AudioRaiseVolume" = "exec wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 0.05+";
          "XF86AudioLowerVolume" = "exec wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 0.05-";
          "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";

          "${modifier}+Left" = "focus left";
          "${modifier}+h" = "focus left";
          "${modifier}+Down" = "focus down";
          "${modifier}+j" = "focus down";
          "${modifier}+Up" = "focus up";
          "${modifier}+k" = "focus up";
          "${modifier}+Right" = "focus right";
          "${modifier}+l" = "focus right";

          "${modifier}+Shift+C" = "reload";
        }
        // builtins.listToAttrs (lib.flatten (builtins.genList (
            i: let
              key =
                if i == 9
                then "0"
                else toString (i + 1);
              ws = toString (i + 1);
            in [
              {
                name = "${modifier}+${key}";
                value = "workspace ${ws}";
              }
              {
                name = "${modifier}+Shift+${key}";
                value = "move container to workspace ${ws}";
              }
            ]
          )
          10))
        // lib.optionalAttrs (hostName == "tybeast") {
          "${modifier}+comma" = "focus output 'DP-2'";
          "${modifier}+period" = "focus output 'DP-1'";
          "${modifier}+slash" = "focus output 'HDMI-A-2'";

          "${modifier}+Shift+comma" = "move output 'DP-2'";
          "${modifier}+Shift+period" = "move output 'DP-1'";
          "${modifier}+Shift+slash" = "move output 'HDMI-A-2'";

          "${modifier}+r" = "exec ~/.config/sway/music.sh";
          "${modifier}+z" = "exec ~/.config/sway/scratch.sh";
        };
    };
    extraConfig = ''
      workspace 1 output DP-2
      workspace 2 output DP-1
      workspace 3 output HDMI-A-2
      workspace 4 output DP-2
      workspace 5 output DP-1
      workspace 6 output HDMI-A-2
      workspace 7 output DP-2
      workspace 8 output DP-1
      workspace 9 output HDMI-A-2

      workspace 20 output HDMI-A-2
      workspace 21 output HDMI-A-2
      set $uifont "Ubuntu 14"
      set $highlight #3daee9
      set $prompt #18b218
      for_window [window_role="pop-up"] floating enable
      for_window [window_role="bubble"] floating enable
      for_window [window_role="task_dialog"] floating enable
      for_window [window_role="Preferences"] floating enable
      for_window [window_type="dialog"] floating enable
      for_window [window_type="menu"] floating enable
      for_window [window_role="About"] floating enable
      for_window [class="xdg-desktop-portal-kde"] floating enable
      for_window [class="ksysguard"] floating enable
      for_window [class="ksysguard"] sticky enable
      for_window [class="Wine"] floating enable
      for_window [app_id="lutris"] floating enable

      assign [class="^steam_app_"] workspace number 5
      assign [app_id="^com.moonlight_stream.Moonlight$"] workspace number 5

      bar {
          mode hide
          hidden_state hide
          modifier none
          font $uifont

          # When the status_command prints a new line to stdout, swaybar updates.
          # The default just shows the current date and time.
          status_command while date +'%-d.%-m.%Y. %H:%M:%S %p'; do sleep 1; done

          colors {
              statusline #ffffff
              background #121212
              #background #00000000
              focused_workspace #121212 #18b218 #232627
              active_workspace #121212 $highlight #232627
              inactive_workspace #121212 #7f8c8d #232627
          }
      }
      #
      # Titlebars
      #
      default_border pixel
      default_floating_border pixel
      hide_edge_borders smart
      #
      # Colors #93cee9
      #
      # class                     border  backgr. text  indicator child_border
          client.focused          #4c7899 #285577 #ffffff $highlight $highlight
          client.focused_inactive #333333 #5f676a #ffffff #484e50 #5f676a
          client.unfocused        #333333 #222222 #888888 #292d2e #222222
          client.urgent           #2f343a #900000 #ffffff #900000 #900000
    '';
  };
}
