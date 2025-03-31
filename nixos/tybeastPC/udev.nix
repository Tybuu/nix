{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: let
  extraUdevRules = pkgs.writeTextFile {
    name = "extra-udev-rules";
    text = builtins.readFile ./udev.txt;
    destination = "/etc/udev/rules.d/69-probe-rs.rules";
  };
in {
  services.udev.packages = [extraUdevRules];
}
