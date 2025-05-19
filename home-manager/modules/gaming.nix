{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    osu-lazer-bin
    stable.moonlight-qt
    lutris
    xclicker
  ];
}
