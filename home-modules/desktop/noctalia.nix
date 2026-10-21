{ lib, config, ... }:
{
  config = lib.mkIf config.redots.desktop.enable {
    programs.noctalia = {
      enable = true;
      systemd.enable = true;

      settings = {
        shell = {
          corner_radius_scale = 0.5;
          telemetry_enabled = false;
          setup_wizard_enabled = false;

          external_ip_enabled = true;
          polkit_agent = true;
          password_style = "default";
          launch_apps_as_systemd_services = true;

          clipboard_enabled = true;
          clipboard_keep_from_closed_apps = true;
          clipboard_auto_paste = "off";

          mpris.blacklist = [ "TelegramDesktop" ];

          panel = {
            wallpaper_show_names = false;
            open_near_click_control_center = true;
          };

          launcher = {
            layout = "simple";
            categories = false;
            compact = true;
            sort_by_usage = true;
            auto_paste = "off";
            provider_prefix = ".";
          };

          screenshot = {
            save_to_file = false;
            copy_to_clipboard = true;
            freeze_screen = true;
            annotate = true;
          };
        };

        lockscreen = {
          enabled = true;
          lock_before_suspend = true;
          fingerprint = true;
          allow_empty_password = false;
          transition = [ "disc" ];
          transition_duration = 500;
          blur_intensity = 0;
          tint_intensity = 0;
        };

        widget = {
          battery = {
            display_mode = "graphic";
            show_label = true;
            label_content = "percent";
          };
          network = {
            vpn_status = "both";
          };
        };

        bar.default = {
          enabled = true;
          position = "top";
          smart_auto_hide = true;
          reserve_space = false;

          thickness = 30;
          margin_ends = 0;
          margin_edge = 0;
          padding = 10;

          start = [
            "notifications"
            "tray"
          ];
          center = [ "clock" ];
          end = [
            "network"
            "volume"
            "caffeine"
            "battery"
          ];
        };

        control_center = {
          sidebar = "compact";
          show_shortcut_labels = false;
          hidden_tabs = [ "monitor" ];
          shortcuts = [
            { type = "nightlight"; }
          ];
        };

        theme = {
          mode = "dark";
          source = "community";
          builtin = "Gruvbox";
          community_palette = "Oxocarbon";
        };
        wallpaper = {
          enabled = true;
          fill_mode = "stretch";
          transition = [ "fade" ];
          transition_duration = 1000;
          transition_on_startup = false;
          directory = ./wallpapers;
          automation = {
            enabled = true;
            interval_seconds = 3600;
            order = "random";
          };
        };

        audio = {
          enable_overdrive = true;
          enable_screenshot_sounds = false;
        };

        battery.warning_threshold = 15;

        idle = {
          behavior_order = [
            "lock"
            "suspend"
          ];
          pre_action_fade_seconds = 2.0;

          behavior = {
            lock = {
              enabled = true;
              timeout = 300;
              action = "lock";
            };
            suspend = {
              enabled = true;
              timeout = 330;
              action = "suspend";
            };
          };
        };

        location.auto_locate = true;
        nightlight.enabled = false;
        weather.enabled = true;

        notification = {
          enable_daemon = true;
          follow_focused_output = true;
          position = "bottom_right";
          width = 240;
          offset_x = 10;
          offset_y = 10;
        };

        system.monitor.enabled = true;
      };
    };
  };
}
