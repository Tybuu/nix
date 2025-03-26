{
  pkgs,
  lib,
  ...
}: {
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "~/.config/nix/home-manager/modules/wallpaper.png"
      ];
      wallpaper = [", ~/.config/nix/home-manager/modules/wallpaper.png"];
    };
  };
}
