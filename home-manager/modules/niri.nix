{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.niri.homeModules.niri
  ];
  programs.niri.settings = {
    spawn-at-startup = [
      {argv = ["waybar"];}
      {argv = ["hyprpaper"];}
    ];
    hotkey-overlay.skip-at-startup = true;
    input = {
      warp-mouse-to-focus.enable = true;
      focus-follows-mouse = {
        enable = true;
        max-scroll-amount = "0%";
      };
    };
    outputs."DP-2" = {
      # mode = "2560x1440@180";
      mode = {
        width = 2560;
        height = 1440;
        refresh = 180.;
      };
      position = {
        x = 1920;
        y = 0;
      };
      scale = 1;
    };
    outputs."DP-1" = {
      mode = {
        width = 1920;
        height = 1080;
        refresh = 144.001;
      };
      position = {
        x = 0;
        y = 0;
      };
      scale = 1;
    };
    outputs."HDMI-A-1" = {
      mode = {
        width = 1920;
        height = 1080;
      };
      position = {
        x = 2560 + 1920;
        y = 0;
      };
      scale = 1;
    };

    layout = {
      gaps = 16;
      center-focused-column = "never";
      preset-column-widths = [
        {proportion = 1. / 3.;}
        {proportion = 1. / 2.;}
        {proportion = 2. / 3.;}
      ];
      default-column-width = {proportion = 1. / 2.;};
      focus-ring = {
        width = 4;
        active = {
          color = "#7fc8ff";
        };
        inactive = {
          color = "#505050";
        };
      };
    };

    workspaces = {
      "burner" = {
        open-on-output = "HDMI-A-1";
      };
      "music" = {
        open-on-output = "HDMI-A-1";
      };
    };
    binds = with config.lib.niri.actions; {
      "Mod+T".action.spawn = "foot";
      "Mod+B".action.spawn = "firefox";
      "Mod+P".action.spawn = "~/.config/niri/music.sh";
      "Mod+Shift+S".action.spawn-sh = "hyprshot -m region";
      "Mod+D".action.spawn-sh = "echo -ne '\\x01' | socat - UNIX-SENDTO:/tmp/stream_temp";
      "Mod+R".action.spawn-sh = "wofi --show drun";

      "XF86AudioRaiseVolume".action.spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+";
      "XF86AudioLowerVolume".action.spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-";
      "XF86AudioMute".action.spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
      "XF86AudioMicMute".action.spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";

      "Mod+O".action = toggle-overview;
      "Mod+C".action = close-window;

      "Mod+Left".action = focus-column-left;
      "Mod+Down".action = focus-window-down;
      "Mod+Up".action = focus-window-up;
      "Mod+Right".action = focus-column-right;
      "Mod+H".action = focus-column-left;
      "Mod+J".action = focus-window-down;
      "Mod+K".action = focus-window-up;
      "Mod+L".action = focus-column-right;

      "Mod+Shift+Left".action = move-column-left;
      "Mod+Shift+Down".action = move-window-down;
      "Mod+Shift+Up".action = move-window-up;
      "Mod+Shift+Right".action = move-column-right;
      "Mod+Shift+H".action = move-column-left;
      "Mod+Shift+J".action = move-window-down;
      "Mod+Shift+K".action = move-window-up;
      "Mod+Shift+L".action = move-column-right;

      "Mod+Comma".action.focus-monitor = "DP-1";
      "Mod+Period".action.focus-monitor = "DP-2";
      "Mod+Slash".action.focus-monitor = "HDMI-A-1";
      "Mod+Shift+Comma".action.move-column-to-monitor = "DP-1";
      "Mod+Shift+Period".action.move-column-to-monitor = "DP-2";
      "Mod+Shift+Slash".action.move-column-to-monitor = "HDMI-A-1";

      # Consume one window from the right to the bottom of the focused column.
      "Mod+Ctrl+Left".action = consume-window-into-column;
      "Mod+Ctrl+H".action = consume-window-into-column;
      # Expel the bottom window from the focused column to the right.
      "Mod+Ctrl+Right".action = expel-window-from-column;
      "Mod+Ctrl+J".action = expel-window-from-column;
      # The following binds move the focused window in and out of a column.
      # If the window is alone, they will consume it into the nearby column to the side.
      # If the window is already in a column, they will expel it out.
      "Mod+Ctrl+Up".action = consume-or-expel-window-left;
      "Mod+Ctrl+K".action = consume-or-expel-window-left;
      "Mod+Ctrl+Down".action = consume-or-expel-window-right;
      "Mod+Ctrl+L".action = consume-or-expel-window-right;

      "Mod+1".action = focus-workspace 1;
      "Mod+2".action = focus-workspace 2;
      "Mod+3".action = focus-workspace 3;
      "Mod+4".action = focus-workspace 4;
      "Mod+5".action = focus-workspace 5;
      "Mod+6".action = focus-workspace 6;
      "Mod+7".action = focus-workspace 7;
      "Mod+8".action = focus-workspace 8;
      "Mod+9".action = focus-workspace 9;
      "Mod+Shift+1".action = move-column-to-index 1;
      "Mod+Shift+2".action = move-column-to-index 2;
      "Mod+Shift+3".action = move-column-to-index 3;
      "Mod+Shift+4".action = move-column-to-index 4;
      "Mod+Shift+5".action = move-column-to-index 5;
      "Mod+Shift+6".action = move-column-to-index 6;
      "Mod+Shift+7".action = move-column-to-index 7;
      "Mod+Shift+8".action = move-column-to-index 8;
      "Mod+Shift+9".action = move-column-to-index 9;

      "Mod+M".action = maximize-column;
      "Mod+Shift+M".action = fullscreen-window;

      "Mod+V".action = toggle-window-floating;
      "Mod+Shift+V".action = switch-focus-between-floating-and-tiling;

      "Mod+Shift+E".action = quit;
    };
  };
}
