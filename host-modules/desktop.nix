{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    redots.desktop.enable = lib.mkEnableOption "desktop & laptop configuration";
  };

  config = lib.mkIf config.redots.desktop.enable {
    # Activate home-manager before starting graphical session
    systemd.user.targets.graphical-session-pre = {
      requires = [ "systemd-user-sessions.service" ];
      after = [ "systemd-user-sessions.service" ];
    };

    xdg = {
      autostart.enable = true;
      menus.enable = true;
      mime.enable = true;
      icons.enable = true;
      sounds.enable = true;

      portal = {
        enable = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-gnome
          xdg-desktop-portal-gtk
        ];
        configPackages = [ pkgs.niri ];
      };
    };
    environment.pathsToLink = [
      "/share/applications"
      "/share/xdg-desktop-portal"
    ];

    security.rtkit.enable = true;
    services = {
      libinput.enable = true;
      printing.enable = true;
      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };
      upower = {
        enable = true;
        usePercentageForPolicy = true;
      };
      logind.settings.Login = {
        HandleLidSwitch = "suspend";
        SleepOperation = "suspend";
        HandlePowerKey = "suspend";
        HandlePowerKeyLongPress = "poweroff";
      };
      displayManager.noctalia-greeter = {
        enable = true;
        settings = {
          session.default = "niri";
          keyboard = {
            layout = "us,ru";
            options = "grp:toggle,grp:win_space_toggle,ctrl:nocaps";
          };
          appearance = {
            scheme = "Gruvbox";
            scheme_selector_position = "hidden";
            password_style = "default";
            hide_logo = true;
            theme_mode = "dark";
          };
          cursor = {
            path = pkgs.bibata-cursors;
            theme = "Bibata-Modern-Classic";
          };
        };
      };
    };

    programs.niri.enable = true;

    powerManagement.enable = true;
    hardware = {
      steam-hardware.enable = true;
      graphics = {
        enable = true;
        enable32Bit = true;
      };
      bluetooth = {
        enable = true;
        powerOnBoot = true;
        settings = {
          Policy.AutoEnable = true;
        };
      };
    };
  };
}
