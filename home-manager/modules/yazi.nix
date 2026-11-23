{
  pkgs,
  lib,
  ...
}: {
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      manager = {
        mouse_events = ["click" "scroll" "touch"];
      };
    };
  };
}
