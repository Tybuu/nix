# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./modules/nvim.nix
    ./modules/hyprpaper.nix
    ./modules/kitty.nix
    ./modules/fish.nix
    ./modules/ghostty.nix
    ./modules/waybar.nix
  ];
  # You can import other home-manager modules here
  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "tybuu";
    homeDirectory = "/home/tybuu";
  };

  # Add stuff for your user as you see fit:
  home.packages = with pkgs; [
    btop
    eza
    wl-clipboard
    firefox
    curl
    usbutils
    hyprshot
    hyprpaper
    bluetuith
    bash
    vim
    nautilus
    wofi
    brightnessctl
    cargo
    rustc
    gcc
    python3
    btop
    usbutils
    unzip
    xclicker
    google-chrome
  ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.zoxide.enable = true;
  programs.starship.enable = true;
  programs.zoxide.enableFishIntegration = true;
  programs.git = {
    enable = true;
    userName = "tybuu";
    userEmail = "tybuu1234@gmail.com";
  };
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.gnome-themes-extra;
      name = "Adwaita-dark";
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}
