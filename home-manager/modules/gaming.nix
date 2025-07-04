{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    osu-source.osu-lazer-bin
    moonlight-qt
    lutris
    xclicker
  ];
}
