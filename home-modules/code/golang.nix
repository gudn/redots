{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    redots.code.golang.enable = lib.mkEnableOption "go language support";
  };

  config = lib.mkIf config.redots.code.golang.enable (
    lib.mkMerge [
      (lib.mkIf config.redots.helix.enable {
        programs.helix.languages = {
          language = [
            {
              name = "go";
              auto-format = true;
              formatter = {
                command = "${pkgs.unstable.golangci-lint}/bin/golangci-lint";
                args = [
                  "fmt"
                  "--stdin"
                ];
              };
            }
          ];
        };
      })
    ]
  );
}
