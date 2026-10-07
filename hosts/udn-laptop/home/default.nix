{ pkgs, ... }:
{
  imports = [
    ./dev.nix
  ];

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
      blender
      ffmpeg
      gimp
      steam
      wireshark
      qFlipper
    ];

    xdg.desktopEntries.steam-offload = {
      name = "Steam Offload";
      icon = "steam";
      exec = "nvidia-offload ${pkgs.steam}/bin/steam %U";
      terminal = false;
      type = "Application";
      categories = [
        "Network"
        "FileTransfer"
        "Game"
      ];
    };
  };
}
