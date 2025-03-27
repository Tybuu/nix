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
      wallpaper = [", ~/.config/nix/home-manager/wallpaper.png"];
    };
  };
}
