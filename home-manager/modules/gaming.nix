{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    osu-source.osu-lazer-bin
    stable.moonlight-qt
    xclicker
  ];
}
