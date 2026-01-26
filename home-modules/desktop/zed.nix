{
  pkgs,
  lib,
  config,
  osConfig,
  ...
}:
{
  options = {
    my.zed.enable = lib.mkEnableOption "Enable Zed editor";
  };

  config = lib.mkIf (config.my.zed.enable && osConfig.my.desktop.enable) {
    programs.zed-editor = {
      enable = true;
      package = pkgs.zed-editor;
      extraPackages = [
        pkgs.nil
        pkgs.nixd
      ];
      mutableUserKeymaps = false;
      mutableUserSettings = false;
      mutableUserTasks = false;
      userSettings = {
        auto_update = false;
        disable_ai = true;
        telemetry = {
          diagnostics = false;
          metrics = false;
        };

        cursor_blink = false;
        buffer_font_family = "JetBrainsMono Nerd Font";
        theme = "Gruvbox Dark";
        colorize_brackets = true;

        base_keymap = "VSCode";
        use_smartcase_search = true;
        restore_on_file_reopen = false;
        restore_on_startup = "none";
        terminal = {
          shell.program = "${pkgs.fish}/bin/fish";
        };

        tab_size = 2;
        languages = {
          Python = {
            tab_size = 4;
          };
        };
      };
      extensions = [
        "html"
        "java"
        "nix"
        "sql"
        "toml"
      ];
    };
  };
}
