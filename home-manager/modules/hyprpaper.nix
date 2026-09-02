{
  pkgs,
  lib,
  ...
}: {
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "~/.config/nix/home-manager/wallpapers/uhh.jpg"
      ];
      wallpaper = {
        monitor = "";
        path = "~/.config/nix/home-manager/wallpapers/uhh.jpg";
      };
    };
  };
}
