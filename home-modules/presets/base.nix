{
  pkgs,
  lib,
  config,
  ...
}:
let
  rennn =
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
{
  options = {
    redots.presets.base.enable = lib.mkEnableOption "base preset";
  };

  config = lib.mkIf config.redots.presets.base.enable {
    redots = {
      presets.core.enable = true;
      lazygit.enable = true;
      fish.enable = true;
      helix.enable = true;
      btop.enable = true;
    };

    programs = {
      zoxide.enable = true;
      bash.initExtra = ''
        source ${rennn}/share/quitcd/quitcd.bash_sh_zsh
      '';
      fish.interactiveShellInit = lib.mkIf config.redots.fish.enable ''
        source ${rennn}/share/quitcd/quitcd.fish
      '';
      direnv = {
        enable = true;
        enableBashIntegration = true;
        enableFishIntegration = config.redots.fish.enable;
        nix-direnv.enable = true;
      };
      git.ignores = lib.mkIf config.redots.git.enable [ ".direnv/ " ];
    };

    home.packages = with pkgs; [
      aria2
      atool
      binwalk
      fastfetch
      fd
      gnuplot
      jq
      p7zip
      parallel
      rennn
      ripgrep
      rsync
      sqlite-interactive
      unzip
      wget
      zip
    ];
  };
}
