{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  environment.systemPackages = with pkgs; [
    lutris
    glib
    glib-networking
    libproxy
    dconf
  ];
}
