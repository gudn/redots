{
  pkgs,
  lib,
  osConfig,
  ...
}:
{
  config = lib.mkIf osConfig.my.desktop.enable {
    home.packages = [ pkgs.nixos-icons ];

    programs.firefox = {
      enable = true;
      policies = {
        AutofillAddressEnabled = false;
        AutofillCreditCardEnabled = false;
        DisableAppUpdate = true;
        DisableAccounts = true;
        DisableFeedbackCommands = true;
        DisableFirefoxAccounts = true;
        DisableFirefoxScreenshots = true;
        DisableFirefoxStudies = true;
        DisableSetDesktopBackground = true;
        DisableTelemetry = true;
        DontCheckDefaultBrowser = true;
        FirefoxHome = {
          SponsoredTopSites = false;
          Pocket = false;
          SponsoredPocket = false;
        };
        FirefoxSuggest = {
          SponsoredSuggestions = false;
        };
        PasswordManagerEnabled = false;
        UserMessaging = {
          WhatsNew = false;
          ExtensionRecommendations = false;
          FeatureRecommendations = false;
          UrlbarInterventions = false;
          SkipOnboarding = true;
          MoreFromMozilla = false;
          FirefoxLabs = false;
        };
      };

      profiles.default = {
        settings = {
          "browser.aboutConfig.showWarning" = false;
          "browser.compactmode.show" = true;
          "browser.contentblocking.report.hide_vpn_banner" = true;
          "browser.tabs.closeWindowWithLastTab" = false;
          "browser.uidensity" = 1;
          "browser.uiCustomization.state" = {
            placements = {
              widget-overflow-fixed-list = [ ];
              unified-extensions-area = [ ];
              nav-bar = [
                "back-button"
                "forward-button"
                "stop-reload-button"
                "urlbar-container"
                "downloads-button"
                "_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action"
                "unified-extensions-button"
              ];
              toolbar-menubar = [ "menubar-items" ];
              TabsToolbar = [
                "firefox-view-button"
                "tabbrowser-tabs"
                "new-tab-button"
                "alltabs-button"
              ];
              vertical-tabs = [ ];
              PersonalToolbar = [ ];
            };
            currentVersion = 22;
            newElementCount = 3;
          };
          "browser.urlbar.shortcuts.actions" = false;
          "browser.urlbar.shortcuts.bookmarks" = false;
          "browser.urlbar.shortcuts.history" = false;
          "browser.urlbar.shortcuts.tabs" = false;
          "browser.urlbar.suggest.bookmark" = false;
          "browser.urlbar.suggest.engines" = false;
          "browser.urlbar.suggest.quickactions" = false;
          "browser.urlbar.suggest.topsites" = false;
          "browser.urlbar.suggest.trending" = false;
          "browser.urlbar.trimHttps" = false;
          "browser.urlbar.trimURLs" = false;
          "layout.css.prefers-color-scheme.content-override" = 0;
        };

        search = {
          force = true;
          default = "google";
          privateDefault = "ddg";
          order = [
            "google"
            "ddg"
            "nix-packages"
          ];
          engines = {
            bing.metaData.hidden = true;
            wikipedia.metaData.hidden = true;

            nix-packages = {
              id = "nix-packages";
              name = "Nix Packages";
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "type";
                      value = "packages";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];

              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@np" ];
            };

            perplexity = {
              id = "perplexity";
              name = "Perplexity";

              urls = [
                {
                  template = "https://www.perplexity.ai/";
                  params = [
                    {
                      name = "q";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];

              icon = "https://www.perplexity.ai/favicon.ico";
              definedAliases = [ "@p" ];
            };
          };
        };

        extensions = {
          packages = with pkgs.nur.repos.rycee.firefox-addons; [
            bitwarden
            ublock-origin
            foxyproxy-standard
            videospeed
          ];
        };
      };
    };

    xdg.mimeApps.defaultApplications = {
      "text/html" = [ "firefox.desktop" ];
      "text/xml" = [ "firefox.desktop" ];
      "x-scheme-handler/http" = [ "firefox.desktop" ];
      "x-scheme-handler/https" = [ "firefox.desktop" ];
      "application/pdf" = [ "firefox.desktop" ];
    };
  };
}
