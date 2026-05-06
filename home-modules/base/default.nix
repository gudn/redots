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
          cdg = "cd (${pkgs.git}/bin/git rev-parse --show-toplevel)";
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
      btop = {
        enable = true;
        settings = {
          color_theme = "gruvbox_dark_v2";
          presets = "cpu:1:default,proc:0:default cpu:0:default,mem:0:default,net:0:default";
          proc_sorting = "cpu lazy";
          show_disks = false;
          cpu_single_graph = true;
          cpu_graph_upper = "total";
        };
      };
    };
  };
}
