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
    networkmanager = {
      enable = true;
    };
  };
  systemd.services.NetworkManager-wait-online.enable = false;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  environment.systemPackages = with pkgs; [
    wineWow64Packages.waylandFull
    webkitgtk_6_0
    rclone
    protonup-ng
    vulkan-tools
    sshfs
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
        libx11
        libxcursor
        libxrandr
        libxi
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

  services = {
    power-profiles-daemon.enable = false;
    tlp = {
      enable = true;
      settings = {
        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        # STOP_CHARGE_THRESH_BAT0 = 1;
        USB_DENYLIST = "0b95:1790";
        STOP_CHARGE_THRESH_BAT1 = 1;
      };
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
