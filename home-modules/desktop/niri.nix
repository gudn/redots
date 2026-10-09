{
  pkgs,
  lib,
  config,
  osConfig,
  ...
}:
{
  config = lib.mkIf config.redots.desktop.enable {
    assertions = [
      {
        assertion = osConfig.programs.niri.enable;
        message = "Niri must be enabled in NixOS module";
      }
    ];

    wayland.windowManager.niri = {
      enable = true;
      enableDefaultConfig = false;
      systemd.enable = false;
      portalPackage = null;

      settings = {
        debug = {
          keep-laptop-panel-on-when-lid-is-closed = { };
          honor-xdg-activation-with-invalid-serial = { };
        };

        screenshot-path = null;
        gestures.hot-corners.off = { };
        recent-windows.off = { };
        hotkey-overlay.skip-at-startup = { };

        input = {
          keyboard = {
            xkb = {
              layout = "us,ru";
              options = "grp:toggle,grp:win_space_toggle,ctrl:nocaps";
            };
          };

          touchpad = {
            natural-scroll = { };
            dwt = { };
            click-method = "clickfinger";
            middle-emulation = { };
          };

          focus-follows-mouse._props.max-scroll-amount = "0%";
          disable-power-key-handling = { };
        };

        layout = {
          gaps = 12;
          center-focused-column = "never";

          focus-ring = {
            width = 4;
            active-color = "#b5e8a9";
            inactive-color = "#212121";
          };

          border.off = { };

          shadow = { };

          struts = {
            top = -4;
            bottom = -4;
            left = -4;
            right = -4;
          };

          default-column-width.proportion = 0.5;
          preset-column-widths._children = [
            { proportion = 0.33333; }
            { proportion = 0.5; }
            { proportion = 0.66667; }
            { proportion = 1.0; }
          ];

          preset-window-heights._children = [
            { proportion = 0.33333; }
            { proportion = 0.5; }
            { proportion = 0.66667; }
            { proportion = 1.0; }
          ];
        };

        binds =
          let
            noctalia = "${config.programs.noctalia.package}/bin/noctalia";
          in
          {
            "Mod+Shift+Slash".show-hotkey-overlay = { };

            "Mod+T" = {
              _props.hotkey-overlay-title = "Open a Terminal";
              spawn = [ "${config.programs.kitty.package}/bin/kitty" ];
            };
            "Mod+D" = {
              _props.hotkey-overlay-title = "Open a Launcher";
              spawn = [
                noctalia
                "msg"
                "panel-toggle"
                "launcher"
              ];
            };
            "Mod+C" = {
              _props.hotkey-overlay-title = "Open a clipboard manager";
              spawn = [
                noctalia
                "msg"
                "panel-toggle"
                "clipboard"
              ];
            };
            "Mod+E" = {
              _props.hotkey-overlay-title = "Open a control center";
              spawn = [
                noctalia
                "msg"
                "panel-toggle"
                "control-center"
              ];
            };
            "Mod+G" = {
              _props.hotkey-overlay-title = "Open a system monitor";
              spawn = [
                noctalia
                "msg"
                "panel-toggle"
                "control-center"
                "system"
              ];
            };

            XF86AudioRaiseVolume = {
              _props.allow-when-locked = true;
              spawn = [
                noctalia
                "msg"
                "volume-up"
              ];
            };
            XF86AudioLowerVolume = {
              _props.allow-when-locked = true;
              spawn = [
                noctalia
                "msg"
                "volume-down"
              ];
            };
            XF86AudioMute = {
              _props.allow-when-locked = true;
              spawn = [
                noctalia
                "msg"
                "volume-mute"
              ];
            };
            XF86AudioMicMute = {
              _props.allow-when-locked = true;
              spawn = [
                noctalia
                "msg"
                "mic-mute"
              ];
            };

            XF86MonBrightnessUp = {
              _props.allow-when-locked = true;
              spawn = [
                noctalia
                "msg"
                "brightness-up"
              ];
            };
            XF86MonBrightnessDown = {
              _props.allow-when-locked = true;
              spawn = [
                noctalia
                "msg"
                "brightness-down"
              ];
            };

            "Mod+O" = {
              _props.repeat = false;
              toggle-overview = { };
            };
            "Mod+Backspace" = {
              _props.repeat = false;
              close-window = { };
            };

            "Mod+Left".focus-column-left = { };
            "Mod+Down".focus-window-or-workspace-down = { };
            "Mod+Up".focus-window-or-workspace-up = { };
            "Mod+Right".focus-column-right = { };
            "Mod+H".focus-column-left = { };
            "Mod+J".focus-window-or-workspace-down = { };
            "Mod+K".focus-window-or-workspace-up = { };
            "Mod+L".focus-column-right = { };

            "Mod+Ctrl+Left".move-column-left = { };
            "Mod+Ctrl+Down".move-window-down-or-to-workspace-down = { };
            "Mod+Ctrl+Up".move-window-up-or-to-workspace-up = { };
            "Mod+Ctrl+Right".move-column-right = { };
            "Mod+Ctrl+H".move-column-left = { };
            "Mod+Ctrl+J".move-window-down-or-to-workspace-down = { };
            "Mod+Ctrl+K".move-window-up-or-to-workspace-up = { };
            "Mod+Ctrl+L".move-column-right = { };

            "Mod+Home".focus-column-first = { };
            "Mod+End".focus-column-last = { };
            "Mod+Ctrl+Home".move-column-to-first = { };
            "Mod+Ctrl+End".move-column-to-last = { };

            "Mod+Shift+Left".focus-monitor-left = { };
            "Mod+Shift+Down".focus-monitor-down = { };
            "Mod+Shift+Up".focus-monitor-up = { };
            "Mod+Shift+Right".focus-monitor-right = { };
            "Mod+Shift+H".focus-monitor-left = { };
            "Mod+Shift+J".focus-monitor-down = { };
            "Mod+Shift+K".focus-monitor-up = { };
            "Mod+Shift+L".focus-monitor-right = { };

            "Mod+Shift+Ctrl+Left".move-column-to-monitor-left = { };
            "Mod+Shift+Ctrl+Down".move-column-to-monitor-down = { };
            "Mod+Shift+Ctrl+Up".move-column-to-monitor-up = { };
            "Mod+Shift+Ctrl+Right".move-column-to-monitor-right = { };
            "Mod+Shift+Ctrl+H".move-column-to-monitor-left = { };
            "Mod+Shift+Ctrl+J".move-column-to-monitor-down = { };
            "Mod+Shift+Ctrl+K".move-column-to-monitor-up = { };
            "Mod+Shift+Ctrl+L".move-column-to-monitor-right = { };

            "Mod+Page_Down".focus-workspace-down = { };
            "Mod+Page_Up".focus-workspace-up = { };
            "Mod+U".focus-workspace-down = { };
            "Mod+I".focus-workspace-up = { };
            "Mod+Ctrl+Page_Down".move-column-to-workspace-down = { };
            "Mod+Ctrl+Page_Up".move-column-to-workspace-up = { };
            "Mod+Ctrl+U".move-column-to-workspace-down = { };
            "Mod+Ctrl+I".move-column-to-workspace-up = { };

            "Mod+Shift+Page_Down".move-workspace-down = { };
            "Mod+Shift+Page_Up".move-workspace-up = { };
            "Mod+Shift+Y".move-workspace-to-monitor-left = { };
            "Mod+Shift+O".move-workspace-to-monitor-right = { };
            "Mod+Shift+U".move-workspace-down = { };
            "Mod+Shift+I".move-workspace-up = { };

            "Mod+WheelScrollUp" = {
              _props.cooldown-ms = 150;
              focus-workspace-up = { };
            };
            "Mod+WheelScrollDown" = {
              _props.cooldown-ms = 150;
              focus-workspace-down = { };
            };
            "Mod+WheelScrollLeft" = {
              _props.cooldown-ms = 150;
              focus-column-left = { };
            };
            "Mod+WheelScrollRight" = {
              _props.cooldown-ms = 150;
              focus-column-right = { };
            };

            "Mod+BracketLeft".consume-or-expel-window-left = { };
            "Mod+BracketRight".consume-or-expel-window-right = { };

            "Mod+F".switch-preset-column-width = { };
            "Mod+Ctrl+F".expand-column-to-available-width = { };
            "Mod+R".switch-preset-window-height = { };

            "Mod+F11".fullscreen-window = { };
            "Mod+B".toggle-window-floating = { };
            "Mod+Shift+B".switch-focus-between-floating-and-tiling = { };
            "Mod+W".toggle-column-tabbed-display = { };

            "Print".spawn = [
              noctalia
              "msg"
              "screenshot-region"
            ];
            "Mod+Print".spawn = [
              noctalia
              "msg"
              "screenshot-annotate"
            ];
          };

        _children = [
          {
            window-rule = {
              geometry-corner-radius = 10;
              clip-to-geometry = true;
            };
          }
          {
            window-rule = {
              open-maximized = true;

              _children = [
                { match._props.app-id = "firefox$"; }
                { match._props.app-id = "^org.telegram.desktop$"; }
                { exclude._props.title = "^Picture-In-Picture$"; }
              ];
            };
          }
          {
            window-rule = {
              open-floating = true;
              default-column-width.proportion = 0.33333;
              default-window-height.proportion = 0.33333;

              _children = [
                { match._props.title = "^Picture-In-Picture$"; }
              ];
            };
          }
          {
            layer-rule = {
              match._props.namespace = "^noctalia-backdrop";
              place-within-backdrop = true;
            };
          }
        ];
      };
    };
  };
}
