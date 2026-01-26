{ pkgs, ... }:
{
  imports = [
    ./dev.nix
  ];

  config = {
    my = {
      user.fullname = "Daniil Novoselov";
      user.email = "me@gudn.link";

      base.enable = true;
      ssh-agent.enable = true;

      zed.enable = true;
    };

    home.username = "udn";
    home.homeDirectory = "/home/udn";

    home.stateVersion = "25.05";

    home.packages = with pkgs; [
      blender
      ffmpeg
      gimp
      gnuplot
      steam
      wireshark
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
