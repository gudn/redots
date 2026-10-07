{
  description = "gudn dots";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      nur,
      rust-overlay,
      nix-index-database,
      ...
    }:
    {
      nixosModules = {
        host-modules = ./host-modules;
      };
      nixosConfigurations = {
        udn-laptop = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inputs = {
              inherit
                home-manager
                nixpkgs-unstable
                nur
                rust-overlay
                nix-index-database
                ;
            };
          };
          modules = [
            self.nixosModules.host-modules
            ./hosts/udn-laptop
          ];
        };
      };
    };
}
