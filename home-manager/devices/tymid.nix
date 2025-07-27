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

  home.packages = with pkgs; [
    prusa-slicer
    # kicad
    socat
  ];
}
