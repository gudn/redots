{
  lib,
  osConfig,
  ...
}:
{
  config = lib.mkIf osConfig.my.desktop.enable {
    programs.fuzzel = {
      enable = true;
      settings = {
        main = {
          font = "JetBrainsMono Nerd Font";
        };
        colors = rec {
          background = "212121ff";
          border = "3a3a3aff";
          text = "e0e0e0ff";
          prompt = "d0d0d0ff";
          input = text;
          selection = background;
          selection-match = "ffe6a7ff";
          selection-text = "63a4ffff";
          match = "63a4ffff";
          counter = prompt;
        };
      };
    };
  };
}
