{
  description = "Paolo's Nix Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    cornelis.url = "github:isovector/cornelis";
    cornelis.inputs.nixpkgs.follows = "nixpkgs";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    nix-homebrew.inputs.nixpkgs.follows = "nixpkgs";
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
  };

  outputs =
    { self
    , nixpkgs
    , home-manager
    , disko
    , nix-darwin
    , nix-homebrew
    , ...
    } @ inputs:
    let
      inherit (self) outputs;
    in
    {
      overlays = import ./overlays { inherit inputs; };

      homeConfigurations = { };

      darwinConfigurations = {
        "dq-matterhorn" = nix-darwin.lib.darwinSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
            { nixpkgs.hostPlatform = "aarch64-darwin"; }
            ./hosts/dq-matterhorn/configuration.nix
            nix-homebrew.darwinModules.nix-homebrew
            ./hosts/dq-matterhorn/nix-homebrew.nix
            ./hosts/dq-matterhorn/homebrew.nix
            home-manager.darwinModules.home-manager
            {
              home-manager = {
                extraSpecialArgs = { inherit inputs outputs; };
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "backup";
                users."mrbash".imports = [
                  ./hosts/dq-matterhorn/home.nix
                  ./users/mrbash/interactive.nix
                  ./users/mrbash/dq-matterhorn.nix
                ];
              };
            }
          ];
        };
      };

      nixosConfigurations = { };
    };
}
