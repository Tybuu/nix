{
  lib,
  pkgs,
  config,
  ...
}: let
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
        version = "7.1.12";
        modDirVersion = "7.1.12";

        # Bypass unused/removed kernel options thrown during compilation
        ignoreConfigErrors = true;

        src = fetchFromGitHub {
          owner = "AsahiLinux";
          repo = "linux";
          rev = "b8810ad6442699f610984f3eceea2e3234a50b77"; # tip of fairydust
          hash = "sha256-FTns+uaqYbCYSsH0y7ypTHUzZs3GAM08vRwHGy2Tozc=";
        };

        kernelPatches =
          [
            {
              name = "Asahi config";
              patch = null;
              structuredExtraConfig = with lib.kernel; {
                # Your original working flags
                ARM64_16K_PAGES = yes;
                ARM64_MEMORY_MODEL_CONTROL = yes;
                ARM64_ACTLR_STATE = yes;
                APPLE_WATCHDOG = yes;
                APPLE_M1_CPU_PMU = yes;
                HID_APPLE = module;
                APPLE_PMGR_MISC = yes;
                APPLE_PMGR_PWRSTATE = yes;

                # New 7.1+ Type-C and DisplayPort Alt Mode flags
                TYPEC = yes;
                TYPEC_DP_ALTMODE = yes;
                PHY_APPLE_ATC = module;
                DRM_APPLE = module;
                APPLE_SART = module;
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
  };
}
