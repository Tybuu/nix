{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    osu-lazer-bin
    moonlight-qt
    lutris
    xclicker
  ];
}
