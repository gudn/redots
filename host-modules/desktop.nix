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
      portal.enable = true;
      sounds.enable = true;
    };

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
    };

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

    fonts = {
      enableDefaultPackages = true;
      fontconfig.useEmbeddedBitmaps = true;
      packages = with pkgs; [
        nerd-fonts.jetbrains-mono
        liberation_ttf
      ];
    };

    programs.niri.enable = true;
    services.displayManager.ly.enable = true;

    environment.systemPackages = with pkgs; [
      xdg-utils
      swayidle
      hyprlock
      xwayland-satellite
    ];

    systemd.user.services.swayidle = {
      description = "Idle management daemon for Wayland";
      documentation = [ "man:swayidle(1)" ];

      partOf = [ "graphical-session.target" ];
      after = [ "niri.service" ];
      wantedBy = [ "graphical-session.target" ];
      serviceConfig = {
        ExecStart =
          let
            cmds = [
              "timeout 300 '${pkgs.systemd}/bin/systemctl suspend'"
              "before-sleep '${pkgs.systemd}/bin/loginctl lock-session'"
              "lock '${pkgs.hyprlock}/bin/hyprlock'"
            ];
          in
          "${pkgs.swayidle}/bin/swayidle -w ${builtins.concatStringsSep " " cmds}";
        Restart = "on-failure";
      };
    };
  };
}
