{
  pkgs,
  lib,
  ...
}: {
  programs.noctalia = {
    enable = true;
    settings = {
      theme = {
        mode = "dark";
        source = "builtin";
        builtin = "Catppuccin";
      };

      bar.default = {
        margin_ends = 50;

        start = ["wallpaper" "workspaces"];
        end = ["tray" "notifactions" "network" "bluetooth" "volume" "brightness" "battery" "control-center" "session"];
      };

      control_center = {
        hidden_tabs = ["media"];
      };

      osd.kinds = {
        media = false;
      };

      wallpaper = {
        enabled = true;
        default.path = ../wallpapers/uhh.jpg;
      };
    };
  };
}
