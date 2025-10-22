{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-osu.url = "github:nixos/nixpkgs/nixos-25.05";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    # home-manager.url = "github:nix-community/home-manager/";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    niri.url = "github:sodiboo/niri-flake";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      tybeast = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [./nixos/tybeast/configuration.nix];
      };
      tymid = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./nixos/tymid/configuration.nix
        ];
      };
      tyoga = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [./nixos/tyoga/configuration.nix];
      };
    };
    homeConfigurations = {
      # home-manager configuration entrypoint
      # Available through 'home-manager switch --flake .#username@hostname'
      "tybuu@tybeast" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs =
          {inherit inputs outputs;}
          // {
            hostName = "tybeast";
          };
        # > Our main home-manager configuration file <
        modules = [
          ./home-manager/devices/tybeast.nix
        ];
      };
      "tybuu@tymid" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs =
          {inherit inputs outputs;}
          // {
            hostName = "tymid";
          };
        # > Our main home-manager configuration file <
        modules = [
          ./home-manager/devices/tymid.nix
        ];
      };
      "tybuu@tyoga" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs =
          {inherit inputs outputs;}
          // {
            hostName = "tyoga";
          };
        # > Our main home-manager configuration file <
        modules = [
          ./home-manager/devices/tyoga.nix
        ];
      };
    };
  };
}
