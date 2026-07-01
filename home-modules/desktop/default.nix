{
  pkgs,
  lib,
  osConfig,
  ...
}:
{
  imports = [
    ./firefox.nix
    ./fuzzel.nix
    ./mako.nix
    ./swaybg.nix
    ./kitty.nix
    ./waybar.nix
  ];

  config = lib.mkIf osConfig.my.desktop.enable {
    home.packages = with pkgs; [
      adwaita-icon-theme
      brightnessctl
      foliate
      pavucontrol
      swaybg
      telegram-desktop
      thunar
      wireplumber
      wl-clipboard
      wtype
    ];

    xdg.configFile = {
      "niri/config.kdl".source = ./niri.kdl;
      "hypr/hyprlock.conf".source = ./hyprlock.conf;
    };

    home.file.lock = {
      target = "bin/lock";
      executable = true;
      text = ''
        #!/bin/sh

        exec ${pkgs.systemd}/bin/loginctl lock-session
      '';
    };

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

    gtk = rec {
      enable = true;
      theme = {
        name = "Adwaita-dark";
        package = pkgs.gnome-themes-extra;
      };
      gtk4.theme = theme;
    };

    qt = {
      enable = true;
      style.name = "Adwaita-dark";
    };
  };
}
