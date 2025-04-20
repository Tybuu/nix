{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    pkgs.unstable.osu-lazer-bin
    moonlight-qt
    lutris
    xclicker
  ];
}
