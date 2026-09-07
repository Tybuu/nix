{
  lib,
  pkgs,
  config,
  ...
}: let
  # linux-asahi built from the "fairydust" branch (experimental DisplayPort
  # Alt Mode over USB-C). Same version/structuredExtraConfig as the stock
  # linux-asahi package in nixos-apple-silicon — only the source commit
  # differs.
  linux-fairydust = pkgs.callPackage (
    {
      stdenv,
      lib,
      fetchFromGitHub,
      buildLinux,
      linuxPackagesFor,
      _kernelPatches ? [],
    }: let
      kernel = buildLinux {
        inherit stdenv lib;
        pname = "linux-asahi-fairydust";
        version = "7.0.10";
        modDirVersion = "7.0.10";
        extraMeta.branch = "7.0";

        src = fetchFromGitHub {
          owner = "AsahiLinux";
          repo = "linux";
          rev = "ce3b823962dc839c5d5b0b8198f75bd8c60aeea3"; # tip of the fairydust branch — check for a newer commit before building
          hash = "sha256-FnAY8ZiSR0NaX/qP47034A/mrBwVodWXChusX9H/hxs=";
        };

        kernelPatches =
          [
            {
              name = "Asahi config";
              patch = null;
              structuredExtraConfig = with lib.kernel; {
                ARM64_16K_PAGES = yes;
                ARM64_MEMORY_MODEL_CONTROL = yes;
                ARM64_ACTLR_STATE = yes;
                APPLE_WATCHDOG = yes;
                APPLE_M1_CPU_PMU = yes;
                HID_APPLE = module;
                APPLE_PMGR_MISC = yes;
                APPLE_PMGR_PWRSTATE = yes;
              };
              features.rust = true;
            }
          ]
          ++ _kernelPatches;
      };
    in
      lib.recurseIntoAttrs (linuxPackagesFor kernel)
  ) {_kernelPatches = config.boot.kernelPatches;};
in {
  boot = {
    kernelPackages = lib.mkForce linux-fairydust;
    # Optional: only needed if you also use a DisplayLink adapter
    # extraModulePackages = [ config.boot.kernelPackages.evdi ];
  };
}
