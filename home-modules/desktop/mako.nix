{
  pkgs,
  lib,
  osConfig,
  ...
}:
{
  config = lib.mkIf osConfig.my.desktop.enable {
    home.packages = [ pkgs.mako ];

    xdg.configFile."mako/config".source = (pkgs.formats.keyValue { }).generate "mako-config" {
      on-button-left = "invoke-default-action";
      on-button-middle = "dismiss-group";
      on-button-right = "dismiss";

      background-color = "#212121";
      text-color = "#FFFFFF";
      border-color = "#63A4FF";
      border-radius = 10;
      progress-color = "over #3A3A3A";

      default-timeout = 10000;
    };

    systemd.user.services.mako = {
      Unit = {
        Description = "Lightweight Wayland notification daemon";
        Documentation = "man:mako(1)";
        After = "niri.service";
      };

      Service = {
        Type = "dbus";
        BusName = "org.freedesktop.Notifications";
        ExecCondition = ''${pkgs.bash}/bin/bash -c '[ -n "$WAYLAND_DISPLAY" ]' '';
        ExecStart = "${pkgs.mako}/bin/mako";
        ExecReload = "${pkgs.mako}/bin/makoctl reload";
      };

      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  };
}
