{
  pkgs,
  lib,
  ...
}: {
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      theme = "catppuccin-mocha";
      command = "${pkgs.fish.outPath}/bin/fish --login --interactive";
      font-size = 15;
    };
  };
}
