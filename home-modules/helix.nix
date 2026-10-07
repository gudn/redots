{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    redots.helix.enable = lib.mkEnableOption "helix editor";
  };

  config = lib.mkIf config.redots.helix.enable {
    programs.helix = {
      enable = true;
      defaultEditor = true;
      settings = {
        theme = "gruvbox_dark_hard";
        editor = {
          default-yank-register = "+";
          clipboard-provider = "wayland";
          soft-wrap.enable = false;

          cursor-shape = {
            normal = "block";
            insert = "bar";
            select = "block";
          };
        };
      };
    };
  };
}
