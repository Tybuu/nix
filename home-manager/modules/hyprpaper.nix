{
  pkgs,
  lib,
  ...
}: {
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "~/.config/nix/home-manager/wallpaper.png"
      ];
      wallpaper = {
        monitor = "";
        path = "~/.config/nix/home-manager/wallpaper.png";
      };
    };
  };
}
