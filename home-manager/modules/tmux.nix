{
  pkgs,
  lib,
  ...
}: {
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    shell = "${pkgs.fish}/bin/fish";
  };
}
