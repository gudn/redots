{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    redots.lazygit.enable = lib.mkEnableOption "lazygit";
  };

  config = lib.mkIf config.redots.lazygit.enable {
    assertions = [
      {
        assertion = config.redots.git.enable;
        message = "lazygit must be enabled with git";
      }
    ];

    programs.lazygit = {
      enable = true;
      settings = {
        gui = {
          tabWidth = 2;
          timeFormat = "2006-01-02";
          shortTimeFormat = "15:04";
          showCommandLog = false;
          showBottomLine = false;
        };
        git = {
          autoForwardBranches = "none";

          pagers = [
            {
              pager = builtins.replaceStrings [ "\n" ] [ " " ] ''
                ${pkgs.delta}/bin/delta
                  --dark
                  --paging=never
                  --line-numbers
                  --hunk-header-style syntax
                  --syntax-theme gruvbox-dark
                  --tabs 2
                  --hyperlinks
                  --hyperlinks-file-link-format="lazygit-edit://{path}:{line}"
              '';
            }
          ];
        };
        update = {
          method = "never";
        };
      };
    };
  };
}
