{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    ../core.nix
    ../modules/gaming.nix
  ];

  wayland.windowManager.hyprland = {
    settings = {
      bind = [
        "$mainMod, Z, exec, hyprctl clients | grep \"moonlight\" || [workspace special:gaming silent] moonlight stream tybeast Desktop --1440 --game-optimization --bitrate 69000 --fps 180 --no-hdr"
        "$mainMod, P, exec, ~/.config/hypr/music.sh"
      ];

      windowrule = [
        "workspace 6 silent, initialClass:.*Moonlight.*"
      ];

      monitor = [
        "DP-1, 1920x1080@144, 0x0, 1"
        "DP-2, 2560x1440@180, 1920x-180, 1"
        "HDMI-A-1, preferred, 4480x0, 1"
      ];

      cursor = {
        warp_on_change_workspace = 2;
        default_monitor = "DP-2";
      };

      workspace = [
        "1, monitor:DP-1"
        "2, monitor:DP-1"
        "3, monitor:DP-1"
        "4, monitor:DP-2"
        "5, monitor:DP-2"
        "6, monitor:DP-2"
        "7, monitor:HDMI-A-1"
        "8, monitor:HDMI-A-1:"
        "9, monitor:HDMI-A-1"
      ];
    };
  };
  home.packages = with pkgs; [
    prusa-slicer
  ];
}
