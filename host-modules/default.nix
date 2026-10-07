{
  config,
  inputs,
  ...
}:
{
  imports = [
    ./desktop.nix
    ./flipperzero.nix

    inputs.home-manager.nixosModules.default
    inputs.nur.modules.nixos.default
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
      config.allowUnfree = true;
      overlays = [
        inputs.rust-overlay.overlays.default
        (final: prev: {
          unstable = import inputs.nixpkgs-unstable {
            system = config.nixpkgs.hostPlatform.system;
            config.allowUnfree = true;
          };
        })
      ];
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
        inputs.nix-index-database.homeModules.default
      ];
      useUserPackages = true;
      useGlobalPkgs = true;
    };

    programs.command-not-found.enable = false;
    programs.nix-ld.enable = true;

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
