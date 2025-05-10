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
    ../modules/nvim.nix
  ];

  wayland.windowManager.hyprland = {
    settings = {
      bind = [
        "$mainMod, Z, exec, moonlight stream tybeast Desktop --1440 --game-optimization --bitrate 69000 --fps 180 --no-hdr"
      ];

      monitor = [
        "DP-1, 1920x1080@144, 0x0, 1"
        "DP-2, 2560x1440@180, 1920x-180, 1"
        "HDMI-A-1, preferred, 4480x0, 1"
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
  home.packages = with pkgs; [
    prusa-slicer
  ];
}
