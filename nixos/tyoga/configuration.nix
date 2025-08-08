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
  ];

  networking = {
    hostName = "tyoga";
    networkmanager.enable = true;
    networkmanager.unmanaged = ["interface-name:enp4s0f4u1u2c2"];
    interfaces.enp4s0f4u1u2c2 = {
      # useDHCP = false;
      ipv4.addresses = [
        {
          address = "192.168.10.7";
          prefixLength = 24;
        }
      ];
    };
  };
  systemd.services.NetworkManager-wait-online.enable = false;

  hardware.i2c.enable = true;

  environment.systemPackages = with pkgs; [
  ];

  systemd.services.link = {
    description = "Keyboard Link Service";
    after = ["network.target"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      ExecStart = "/home/tybuu/projects/link/target/release/keyboard-link";
      Restart = "always";
    };
  };

  services = {
    power-profiles-daemon.enable = false;
    tlp = {
      enable = true;
      settings = {
        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        STOP_CHARGE_THRESH_BAT0 = 1;
        USB_DENYLIST = "0b95:1790";
      };
    };
  };
  services.gvfs.enable = true;
}
