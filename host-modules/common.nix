{
  pkgs,
  config,
  inputs,
  redots-pkgs,
  nix-index-database,
  ...
}:
{
  imports = with inputs; [
    home-manager.nixosModules.home-manager
    nur.modules.nixos.default
  ];

  config = {
    nix = {
      settings.experimental-features = [
        "nix-command"
        "flakes"
      ];
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
      };
      optimise = {
        automatic = true;
        dates = [ "weekly" ];
      };
    };

    nixpkgs = {
      overlays =
        let
          unstable-overlay = final: prev: {
            unstable = import inputs.nixpkgs-unstable {
              system = config.nixpkgs.hostPlatform.system;
              config.allowUnfree = true;
            };
          };
        in
        [
          unstable-overlay
          inputs.rust-overlay.overlays.default
        ];

      config.allowUnfree = true;
    };

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking = {
      networkmanager.enable = true;
      nftables.enable = true;
    };

    time.timeZone = "Europe/Moscow";

    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "ru_RU.UTF-8";
      LC_IDENTIFICATION = "ru_RU.UTF-8";
      LC_MEASUREMENT = "ru_RU.UTF-8";
      LC_MONETARY = "ru_RU.UTF-8";
      LC_NAME = "ru_RU.UTF-8";
      LC_NUMERIC = "ru_RU.UTF-8";
      LC_PAPER = "ru_RU.UTF-8";
      LC_TELEPHONE = "ru_RU.UTF-8";
      LC_TIME = "ru_RU.UTF-8";
    };

    home-manager = {
      sharedModules = [
        ../home-modules
        nix-index-database.homeModules.default
      ];
      extraSpecialArgs = { inherit redots-pkgs; };
      useGlobalPkgs = true;
      useUserPackages = true;
    };

    programs.command-not-found.enable = false;

    programs.nix-ld = {
      enable = true;
      libraries = with pkgs; [
        curl
        glibc
        libcxx
        openssl
        zlib
      ];
    };

    environment = {
      homeBinInPath = true;
      localBinInPath = true;
      loginShellInit = ''
        if test -f "/etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh"; then
          . "/etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh"
        fi
      '';
    };
  };
}
