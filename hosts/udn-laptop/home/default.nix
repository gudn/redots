{ pkgs, ... }:
{
  config = {
    redots = {
      user.fullname = "Daniil Novoselov";
      user.email = "me@gudn.link";

      presets.base.enable = true;
      presets.desktop.enable = true;
    };

    home.username = "udn";
    home.homeDirectory = "/home/udn";

    home.stateVersion = "26.05";

    home.packages = with pkgs; [
      ffmpeg
      gimp
      qFlipper
      steam
      wireshark
    ];

    services.podman.enable = true;
    programs.noctalia.settings = {
      shell.avatar_path = ./avatar.jpg;
    };
  };
}
