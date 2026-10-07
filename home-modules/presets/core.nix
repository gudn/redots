{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    redots.presets.core.enable = lib.mkEnableOption "enable core preset";
  };

  config = lib.mkIf config.redots.presets.core.enable {
    redots.git.enable = true;

    programs.nix-index-database.comma.enable = true;
    home.packages = with pkgs; [
      file
    ];
  };
}
