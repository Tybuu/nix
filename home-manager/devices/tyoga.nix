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

  home.packages = with pkgs; [
  ];
}
