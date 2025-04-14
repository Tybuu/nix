{
  pkgs,
  lib,
  config,
  ...
}: let
  catppuccinDrv = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/foot/009cd57bd3491c65bb718a269951719f94224eb7/catppuccin-mocha.conf";
    hash = "sha256-plQ6Vge6DDLj7cBID+DRNv4b8ysadU2Lnyeemus9nx8=";
  };
in {
  programs.foot = {
    enable = true;
    # enableFishIntegration = true;
    # theme = "catppuccin-mocha";
    settings = {
      main = {
        font = "Inconsolata Nerd Font:size=16";
        shell = "${pkgs.fish.outPath}/bin/fish --login --interactive";
        login-shell = true;
        include = "${catppuccinDrv}";
      };
    };
  };
}
