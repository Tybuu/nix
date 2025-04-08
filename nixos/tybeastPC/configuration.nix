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

  networking = {
    hostName = "tybeastPC";
    networkmanager.enable = true;
    interfaces.enp4s0 = {
      useDHCP = false;
      ipv4.addresses = [
        {
          address = "192.168.10.3";
          prefixLength = 24;
        }
      ];
    };
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];
  hardware.opentabletdriver.enable = true;
  hardware.opentabletdriver.daemon.enable = true;
  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of
    # supported GPUs is at:
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # Only available from driver 515.43.04+
    open = true;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  environment.systemPackages = with pkgs; [
    wineWowPackages.waylandFull
    protonup
    gamescope
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  systemd.services.link = {
    description = "Keyboard Link Service";
    after = ["network.target"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      ExecStart = "/home/tybuu/projects/link/target/release/keyboard-link";
      Restart = "always";
    };
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      # Import your home-manager configuration
      tybuu = import ../../home-manager/devices/pc.nix;
    };
  };
  services.gvfs.enable = true;
}
