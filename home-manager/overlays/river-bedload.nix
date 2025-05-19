self: super: {
  river-bedload = self.stdenv.mkDerivation (finalAttrs: {
    pname = "river-bedload";
    version = "0.1.1";

    src = self.fetchFromSourcehut {
      owner = "~novakane";
      repo = "river-bedload";
      rev = "4a2855ca2669372c346975dd6e1f612ca563b131";
      hash = "sha256-CQH2LQi2ga4YDD2ZYb998ExDJHK4TGHq5h3z94703Dc=";
      fetchSubmodules = true;
    };

    deps = self.callPackage ./build.zig.zon.nix {
      zig = self.zig_0_14;
    };

    nativeBuildInputs = [
      self.pkg-config
      self.wayland-scanner
      self.zig_0_14.hook
    ];

    buildInputs = [
      self.wayland
      self.wayland-protocols
    ];

    dontConfigure = true;

    zigBuildFlags = [
      "-Doptimize=ReleaseSafe"
      "--system"
      "${finalAttrs.deps}"
    ];
  });
}
