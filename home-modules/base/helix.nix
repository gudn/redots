{
  pkgs,
  lib,
  config,
  ...
}:
{
  config = lib.mkIf config.my.base.enable {
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
      languages = {
        language-server = {
          clangd = {
            command = "${pkgs.clang-tools}/bin/clangd";
            args = [
              "--background-index"
              "--clang-tidy"
            ];
          };
        };
        language = [
          {
            name = "nix";
            auto-format = true;
            formatter = {
              command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt";
              args = [ "--filename=%{buffer_name}" ];
            };
          }
        ];
      };
    };
  };
}
