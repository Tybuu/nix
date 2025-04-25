# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
    ./hardware-configuration.nix
    ../systemModules/udev.nix
    ../systemModules/system_core.nix
    inputs.home-manager.nixosModules.home-manager
  ];

  networking.hostName = "tyoga";
  networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs; [
  ];

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      # Import your home-manager configuration
      tybuu = import ../../home-manager/devices/tyoga.nix;
    };
  };
}
