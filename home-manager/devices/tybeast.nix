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
        "$mainMod, Z, exec, moonlight stream tybeast Desktop --1440 --game-optimization --bitrate 69000 --fps 180 --no-hdr"
      ];
    };
  };
  home.packages = with pkgs; [
    prusa-slicer
  ];
}
