self: super: {
  agy = self.stdenv.mkDerivation {
    pname = "agy";
    version = "1.0.1";

    src = self.fetchurl {
      url = "https://storage.googleapis.com/antigravity-public/antigravity-cli/1.0.1-5826024320139264/linux-x64/cli_linux_x64.tar.gz";
      sha256 = "sha256-gfoD752FdtCLTMAEjdvtKdPUangB+LRDqTVHHdnAbb4=";
    };

    # This tells Nix that the tarball contains the binary directly
    sourceRoot = ".";

    # Standard installation for a pre-compiled binary
    installPhase = ''
      mkdir -p $out/bin
      cp antigravity $out/bin/agy
      chmod +x $out/bin/agy
    '';
  };
}
