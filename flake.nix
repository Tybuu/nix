{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-osu.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-apple-silicon.url = "github:nix-community/nixos-apple-silicon";
    nixos-apple-silicon.inputs.nixpkgs.follows = "nixpkgs";
    #hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    # Home manager
    # home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.url = "github:nix-community/home-manager/";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
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
      tymini = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        specialArgs = {inherit inputs outputs;};
        modules = [
          inputs.nixos-apple-silicon.nixosModules.apple-silicon-support
          ./nixos/tymini/configuration.nix
        ];
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
      "tybuu@tymini" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.aarch64-linux;
        extraSpecialArgs =
          {inherit inputs outputs;}
          // {
            hostName = "tymini";
          };
        modules = [
          ./home-manager/devices/tymini.nix
        ];
      };
    };
  };
}
