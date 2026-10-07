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

  config =
    let
      customNnn =
        (pkgs.nnn.override {
          withPcre = true;
          withNerdIcons = true;
          extraMakeFlags = [ "O_NOSSN=1" ];
        }).overrideAttrs
          (old: {
            nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ pkgs.makeWrapper ];
            postInstall = ''
              ${old.postInstall or ""}
              wrapProgram $out/bin/nnn \
                --prefix PATH : "${
                  lib.makeBinPath (
                    with pkgs;
                    [
                      atool
                      zip
                      unzip
                    ]
                  )
                }" \
                --set NNN_ARCHMNT "${pkgs.fuse-archive}/bin/fuse-archive" \
                --set NNN_OPENER "$out/share/plugins/nuke" \
                --set NNN_BMS "d:~/Downloads;w:~/work" \
                --set NNN_ORDER "T:~/Downloads" \
                --set NNN_OPTS "xzeAEJR"
            '';
          });
    in
    lib.mkIf config.my.base.enable {
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
        customNnn
      ];

      programs = {
        nix-index-database.comma.enable = true;
        zoxide.enable = true;
        fish = {
          enable = true;
          shellInit = builtins.readFile ./init.fish;
          interactiveShellInit = ''
            source ${customNnn}/share/quitcd/quitcd.fish
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
