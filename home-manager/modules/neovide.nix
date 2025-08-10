{
  pkgs,
  lib,
  ...
}: {
  programs.neovide = {
    enable = true;
    settings = {
      vsync = true;
    };
  };
}
