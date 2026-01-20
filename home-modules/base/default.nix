{
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [
    ./git.nix
    ./helix.nix
  ];

  options = {
    my.base.enable = lib.mkEnableOption "Enable base home settings";
  };

  config = lib.mkIf config.my.base.enable {
    home.packages = with pkgs; [
      aria2
      atool
      bat
      binwalk
      fastfetch
      fd
      file
      htop
      jq
      lshw
      nix-index
      p7zip
      parallel
      ripgrep
      rsync
      sqlite-interactive
      tldr
      unstable.comma
      unzip
      usbutils
      wget
      zip
    ];

    programs = {
      fish = {
        enable = true;
        shellInit = builtins.readFile ./init.fish;
        functions = {
          fish_prompt = builtins.readFile ./prompt.fish;
        };
      };
      yazi = {
        enable = true;
        settings = {
          mgr = {
            sort_by = "natural";
            sort_sensitive = false;
            sort_dir_first = true;
            sort_translit = true;
            show_symlink = false;
          };

          preview = {
            wrap = "no";
            tab_size = 2;
          };
        };
      };
    };
  };
}
