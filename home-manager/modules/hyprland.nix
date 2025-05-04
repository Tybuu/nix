{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./hypr_home/hypr_core.nix
    ./hypr_home/keybinds.nix
  ];
  wayland.windowManager.hyprland = {
    enable = true;

    extraConfig = ''
      source = ~/.config/hypr/temp.conf
    '';
  };
}
