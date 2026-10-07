{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    redots.code.nix.enable = lib.mkEnableOption "nix language support";
  };

  config = lib.mkIf config.redots.code.nix.enable (
    lib.mkMerge [
      (lib.mkIf config.redots.helix.enable {
        programs.helix.languages = {
          language = [
            {
              name = "nix";
              auto-format = true;
              formatter = {
                command = "${pkgs.nixfmt}/bin/nixfmt";
                args = [ "--filename=%{buffer_name}" ];
              };
            }
          ];
        };
      })
    ]
  );
}
