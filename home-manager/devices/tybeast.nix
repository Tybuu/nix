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
    ../modules/tmux.nix
  ];

  home.packages = with pkgs; [
    eden
    prusa-slicer
    ltspice
    fusee-nano
    shadps4-qtlauncher
  ];
}
