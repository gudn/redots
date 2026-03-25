{
  pkgs,
  lib,
  osConfig,
  ...
}:
{
  config = lib.mkIf osConfig.my.desktop.enable {
    programs.kitty = {
      enable = true;
      themeFile = "gruvbox-dark-hard";
      settings = {
        font_family = "JetBrainsMono Nerd Font";
        font_size = 11;
        disable_ligatures = "never";

        cursor_shape = "beam";
        cursor_shape_unfocused = "hollow";
        cursor_blink_interval = 0;

        scrollback_lines = 5000;
        scrollbar = "hovered";

        mouse_hide_wait = 3.0;

        paste_actions = "quote-urls-at-prompt,confirm";
        strip_trailing_spaces = "smart";
        select_by_word_characters = "@-./_~?&=%+#";

        enable_audio_bell = false;
        bell_on_tab = "\"* \"";

        remember_window_size = false;
        remember_window_position = false;
        enabled_layouts = "splits";
        hide_window_decorations = true;

        tab_bar_edge = "bottom";
        tab_bar_style = "powerline";
        tab_bar_align = "left";
        tab_bar_min_tabs = 2;
        tab_powerline_style = "slanted";
        tab_title_template = "{fmt.fg.red}{bell_symbol}{fmt.fg.tab}{tab.progress_percent}{title}";

        close_on_child_death = false;
        allow_remote_control = "socket-only";
        listen_on = "unix:$\{XDG_RUNTIME_DIR}/kitty-{kitty_pid}";

        shell_integration = "enabled";
        notify_on_cmd_finish = "unfocused 15 notify";
        linux_display_server = "wayland";

        shell = "${pkgs.fish}/bin/fish";
        editor = "${pkgs.helix}/bin/hx";
        scrollback_pager = "${pkgs.less}/bin/less --chop-long-lines --RAW-CONTROL-CHARS +INPUT_LINE_NUMBER";
        open_url_with = "${pkgs.xdg-utils}/bin/xdg-open";

        clear_all_shortcuts = true;
      };
      keybindings = {
        "ctrl+c" = "copy_and_clear_or_interrupt";
        "ctrl+shift+v" = "paste_from_clipboard";

        "ctrl+shift+z" = "scroll_to_prompt -1";
        "ctrl+shift+x" = "scroll_to_prompt +1";
        "ctrl+a>h" = "show_scrollback";
        "ctrl+a>r" = "show_last_command_output";

        "ctrl+a>u" = "kitten unicode_input";
        "ctrl+a>f" = "kitten hints --type path --program @";
        "ctrl+a>v" = "kitten hints --type hash --program @";
        "ctrl+a>y" = "kitten hints --type hyperlink";
        "ctrl+a>l" = "kitten hints --type url --url-prefixes http,https";
        "ctrl+a>escape" = "kitty_shell tab";

        "ctrl+equal" = "change_font_size all +2.0";
        "ctrl+plus" = "change_font_size all +2.0";
        "ctrl+minus" = "change_font_size all -2.0";
        "ctrl+backspace" = "change_font_size all 0";
      };
    };
  };
}
