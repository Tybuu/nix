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

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 32768;
    }
  ];
  networking = {
    hostName = "tybeast";
    networkmanager = {
      enable = true;
      plugins = with pkgs; [
        networkmanager-openconnect
      ];
    };
    firewall.allowedTCPPorts = [8188];
    # interfaces.enp4s0 = {
    #   useDHCP = false;
    #   ipv4.addresses = [
    #     {
    #       address = "192.168.10.3";
    #       prefixLength = 24;
    #     }
    #   ];
    # };
  };
  environment.variables = {
    "__GL_SHADER_DISK_CACHE_SIZE" = "12000000000";
  };

  fileSystems."/mnt/disk2" = {
    device = "/dev/disk/by-uuid/391fc4cc-3bf7-40c2-bb3b-030bf78ed485";
    fsType = "ext4";
    options = ["nofail" "user" "exec"];
  };

  services.flatpak.enable = true;
  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];
  hardware.opentabletdriver.enable = true;
  hardware.opentabletdriver.daemon.enable = true;
  hardware.graphics.enable32Bit = true;

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

  programs.gamemode.enable = true;
  environment.systemPackages = with pkgs; [
    wineWowPackages.waylandFull
    webkitgtk_6_0
    protonup-ng
    gamescope
    vulkan-tools
    (lutris.override {
      extraPkgs = pkgs: [
        gamemode
        mangohud
      ];

      extraLibraries = pkgs: [
        stdenv.cc.cc
        zlib
        fuse3
        icu
        nss
        openssl
        curl
        expat
        libglvnd
        vulkan-loader
        xorg.libX11
        xorg.libXcursor
        xorg.libXrandr
        xorg.libXi
        mesa
        libGL
        libxkbcommon

        glib
        gtk3
        pango
        cairo
        gdk-pixbuf
        at-spi2-core
        dbus
        libxml2

        gst_all_1.gstreamer
        gst_all_1.gst-plugins-base
        gst_all_1.gst-plugins-good
        gst_all_1.gst-plugins-bad
        gst_all_1.gst-plugins-ugly
        gst_all_1.gst-libav
      ];
    })
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "no";
    };
  };

  systemd.services.link = {
    description = "Keyboard Link Service";
    after = ["network.target"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      ExecStart = "/home/tybuu/projects/Keyboards-firmware/tybeast_he/link/target/release/keyboard-link";
      Restart = "always";
    };
  };

  services.gvfs.enable = true;
}
