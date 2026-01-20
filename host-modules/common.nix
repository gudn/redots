{
  pkgs,
  nixpkgs-unstable,
  home-manager,
  nur,
  rust-overlay,
  config,
  ...
}:
{
  imports = [
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
            unstable = import nixpkgs-unstable {
              system = config.nixpkgs.hostPlatform.system;
              config.allowUnfree = true;
            };
          };
        in
        [
          unstable-overlay
          rust-overlay.overlays.default
        ];

      config.allowUnfree = true;
    };

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.networkmanager.enable = true;

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
      sharedModules = [ ../home-modules ];
      useGlobalPkgs = true;
      useUserPackages = true;
    };

    programs.command-not-found.enable = false;

    programs.nix-ld = {
      enable = true;
      libraries = with pkgs; [
        glibc
        zlib
        openssl
        curl
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
