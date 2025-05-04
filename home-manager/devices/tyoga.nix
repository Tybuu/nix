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
  ];

  wayland.windowManager.hyprland = {
    settings = {
      bind = [
        "$mainMod, h, movefocus, l"
        "$mainMod, l, movefocus, r"
        "$mainMod, k, movefocus, u"
        "$mainMod, j, movefocus, d"
        "$mainMod SHIFT, h, movewindow, l"
        "$mainMod SHIFT, l, movewindow, r"
        "$mainMod SHIFT, k, movewindow, u"
        "$mainMod SHIFT, j, movewindow, d"
      ];

      monitor = [
        "eDP-1, 1920x1200, 768x1728, 1.25"
        "DP-1, 3840x2160, 0x0, 1.25"
      ];

      workspace = [
        "1, monitor:eDP-1"
        "2, monitor:DP-1"
        "3, monitor:eDP-1"
        "4, monitor:DP-1"
        "5, monitor:eDP-1"
        "6, monitor:DP-1"
        "7, monitor:eDP-1"
        "8, monitor:DP-1"
        "9, monitor:eDP-1"
        "10, monitor:DP-1"
      ];
    };
  };

  home.packages = with pkgs; [
  ];
}
