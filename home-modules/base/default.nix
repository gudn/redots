{
  pkgs,
  lib,
  config,
  redots-pkgs,
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
      p7zip
      parallel
      ripgrep
      rsync
      sqlite-interactive
      tldr
      unzip
      usbutils
      wget
      zip
      redots-pkgs.nnn
    ];

    programs = {
      nix-index-database.comma.enable = true;
      zoxide.enable = true;
      fish = {
        enable = true;
        shellInit = builtins.readFile ./init.fish;
        interactiveShellInit = ''
          source ${redots-pkgs.nnn}/share/quitcd/quitcd.fish
        '';
        functions = {
          fish_prompt = builtins.readFile ./prompt.fish;
          cdg = "cd (${pkgs.git}/bin/git rev-parse --show-toplevel)";
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
