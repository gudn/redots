{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    my.desktop.enable = lib.mkEnableOption "Enable graphical desktop";
  };

  config = lib.mkIf config.my.desktop.enable {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    programs.niri.enable = true;
    services.displayManager.ly.enable = true;
    # Activate home-manager before starting graphical session
    systemd.user.targets.graphical-session-pre = {
      requires = [ "systemd-user-sessions.service" ];
      after = [ "systemd-user-sessions.service" ];
    };

    environment.systemPackages = with pkgs; [
      xdg-utils
      swayidle
      hyprlock
      xwayland-satellite
    ];

    xdg = {
      autostart.enable = true;
      menus.enable = true;
      mime.enable = true;
      icons.enable = true;
      portal.enable = true;
    };

    security.rtkit.enable = true;
    services = {
      libinput.enable = true;
      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };
    };

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
              "timeout 600 '${pkgs.systemd}/bin/systemctl suspend'"
              "before-sleep '${pkgs.systemd}/bin/loginctl lock-session'"
              "lock '${pkgs.hyprlock}/bin/hyprlock'"
            ];
          in
          "${pkgs.swayidle}/bin/swayidle -w ${builtins.concatStringsSep " " cmds}";
        Restart = "on-failure";
      };
    };

    services = {
      blueman.enable = true;
      printing.enable = true;
    };

    fonts = {
      enableDefaultPackages = true;
      fontconfig.useEmbeddedBitmaps = true;
      packages = with pkgs; [
        nerd-fonts.jetbrains-mono
      ];
    };
  };
}
