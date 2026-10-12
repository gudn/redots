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
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia-greeter = {
      url = "github:noctalia-dev/noctalia-greeter";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia";
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
      nix-index-database,
      noctalia-greeter,
      noctalia,
      ...
    }:
    let
      systems = [ "x86_64-linux" ];
      forEachSystem = nixpkgs.lib.genAttrs systems;
    in
    {
      nixosModules = {
        default = { config, ... }: {
          imports = [
            home-manager.nixosModules.default
            nur.modules.nixos.default
            noctalia-greeter.nixosModules.default

            ./host-modules
          ];

          config = {
            nixpkgs = {
              config.allowUnfree = true;
              overlays = [
                (final: prev: {
                  unstable = import nixpkgs-unstable {
                    config = final.config;
                    system = config.nixpkgs.hostPlatform.system;
                  };
                })
              ];
            };

            home-manager = {
              sharedModules = [
                nix-index-database.homeModules.default
                noctalia.homeModules.default

                ./home-modules
              ];
              useUserPackages = true;
              useGlobalPkgs = true;
            };
          };
        };
      };

      nixosConfigurations = {
        udn-laptop = nixpkgs.lib.nixosSystem {
          modules = [
            self.nixosModules.default

            ./hosts/udn-laptop
          ];
        };
      };

      devShells = forEachSystem (system: {
        default =
          let
            pkgs = import nixpkgs { inherit system; };
          in
          pkgs.mkShellNoCC {
            packages = with pkgs; [
              nixfmt
              nixd
            ];
          };
      });

      formatter = forEachSystem (system: nixpkgs.legacyPackages.${system}.nixfmt-tree);
    };
}
