{
  pkgs,
  lib,
  config,
  osConfig,
  ...
}:
{
  imports = [
    ./niri.nix
    ./noctalia.nix
  ];

  options = {
    redots.desktop.enable = lib.mkEnableOption "desktop";
  };

  config = lib.mkIf config.redots.desktop.enable {
    assertions = [
      {
        assertion = osConfig.redots.desktop.enable;
        message = "home desktop configuration enabled without os desktop";
      }
    ];

    home.packages = with pkgs; [
      adwaita-icon-theme
      liberation_ttf
      nerd-fonts.jetbrains-mono
    ];

    fonts.fontconfig.enable = true;

    home.pointerCursor = {
      enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
    };

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };

    gtk = {
      enable = true;
      theme = {
        name = "Adwaita-dark";
        package = pkgs.gnome-themes-extra;
      };
    };

    qt = {
      enable = true;
      style.name = "Adwaita-dark";
    };
  };
}
