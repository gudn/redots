{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    redots.presets.desktop.enable = lib.mkEnableOption "desktop & laptop preset";
  };

  config = lib.mkIf config.redots.presets.desktop.enable {
    redots = {
      desktop.enable = true;
      firefox.enable = true;
      kitty.enable = true;
      ssh-agent.enable = true;
    };

    home.packages = with pkgs; [
      foliate
      lshw
      telegram-desktop
      usbutils
      wtype
      wl-clipboard
    ];
  };
}
