{ lib, ... }:
{
  imports = [
    ./code
    ./desktop
    ./firefox.nix
    ./fish.nix
    ./git.nix
    ./helix.nix
    ./kitty.nix
    ./lazygit.nix
    ./presets
    ./ssh-agent.nix
  ];

  options = {
    redots.user.fullname = lib.mkOption {
      type = lib.types.str;
      default = "No Body";
      description = "Full name of user";
    };
    redots.user.email = lib.mkOption {
      type = lib.types.str;
      default = "nobody@example.com";
      description = "Email of user";
    };
  };

  config = {
    home.preferXdgDirectories = true;

    xdg = {
      mimeApps.enable = true;
      userDirs = {
        enable = true;
        createDirectories = true;
        setSessionVariables = true;
      };
    };

    home.shell.enableShellIntegration = true;
  };
}
