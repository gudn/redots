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
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      nur,
      rust-overlay,
      ...
    }:
    {
      packages.x86_64-linux =
        let
          pkgs = import nixpkgs { system = "x86_64-linux"; };
        in
        {
          nnn = pkgs.callPackage ./pkgs/nnn { };
        };
      nixosModules = {
        host-modules = ./host-modules;
      };
      nixosConfigurations = {
        udn-laptop = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          specialArgs = {
            redots-pkgs = self.packages."${system}";
            inputs = {
              inherit
                home-manager
                nixpkgs-unstable
                nur
                rust-overlay
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
