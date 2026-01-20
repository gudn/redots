{ lib, ... }:
{
  imports = [
    ./base
    ./desktop
    ./ssh-agent.nix
  ];

  options = {
    my.user.fullname = lib.mkOption {
      type = lib.types.str;
      default = "No Body";
      description = "Full name of user";
    };
    my.user.email = lib.mkOption {
      type = lib.types.str;
      default = "nobody@example.com";
      description = "Email of user";
    };
  };

  config = {
    home.preferXdgDirectories = true;
    xdg.userDirs = {
      enable = true;
      createDirectories = true;
    };

    home.shell.enableShellIntegration = true;
  };
}
