{
  pkgs,
  lib,
  osConfig,
  ...
}:
{
  config = lib.mkIf osConfig.my.desktop.enable {
    home.packages = [ pkgs.swaybg ];

    systemd.user.services.swaybg = {
      Unit = {
        PartOf = "niri.service";
        After = "niri.service";
      };
      Service = {
        ExecStart = "${pkgs.swaybg}/bin/swaybg -i ${./wallpaper.png}";
        Restart = "on-failure";
        RestartSec = 2;
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  };
}
