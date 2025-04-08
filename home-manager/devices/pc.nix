# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
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
    ../modules/chrome.nix
    ../modules/hyprpaper.nix
    ../modules/kitty.nix
    ../modules/fish.nix
  ];

  home.packages = with pkgs; [
    prusa-slicer
  ];
}
