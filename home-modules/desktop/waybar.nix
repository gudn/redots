{
  pkgs,
  lib,
  osConfig,
  ...
}:
{
  config = lib.mkIf osConfig.my.desktop.enable {
    home.packages = [ pkgs.waybar ];

    xdg.configFile = {
      "waybar/config.jsonc".source = ./waybar.json;
      "waybar/style.css".source = ./waybar.css;
    };

    systemd.user.services.waybar = {
      Unit = {
        Description = "Highly customizable Wayland bar for Sway and Wlroots based compositors.";
        Documentation = "https://github.com/Alexays/Waybar/wiki";
        PartOf = [
          "niri.service"
          "tray.target"
        ];
        After = [ "niri.service" ];
      };

      Service = {
        ExecStart = "${pkgs.waybar}/bin/waybar";
        ExecReload = "${pkgs.coreutils}/bin/kill -SIGUSR2 $MAINPID";
        KillMode = "mixed";
        Restart = "on-failure";
        RestartSec = 2;
      };

      Install.WantedBy = [
        "graphical-session.target"
        "tray.target"
      ];
    };
  };
}
