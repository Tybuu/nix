{
  pkgs,
  lib,
  ...
}: {
  wayland.windowManager.hyprland = {
    settings = {
      # Monitor Configuration
      monitor = [
        "DP-1, 1920x1080@144, 0x-512, 1, transform, 1"
        "DP-2, 2560x1440@180, 1080x-180, 1"
        "HDMI-A-1, preferred, 3640x0, 1"
      ];

      workspace = [
        "1, monitor:DP-1"
        "2, monitor:DP-2"
        "3, monitor:HDMI-A-1"
        "4, monitor:DP-1"
        "5, monitor:DP-2"
        "6, monitor:HDMI-A-1"
        "7, monitor:DP-1"
        "8, monitor:DP-2"
        "9, monitor:HDMI-A-1"
      ];
    };
  };
}
