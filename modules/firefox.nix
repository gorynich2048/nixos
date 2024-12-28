{ pkgs, ... }: {
  home-manager.users.user = {
    programs = {
      firefox = {
        enable = true;
        nativeMessagingHosts = [
          pkgs.tridactyl-native
        ];

        /* ---- POLICIES ---- */
        # Check about:policies#documentation for options.
        policies = {
          DisableTelemetry = true;
          DisableFirefoxStudies = true;
          EnableTrackingProtection = {
            Value= true;
            Locked = true;
            Cryptomining = true;
            Fingerprinting = true;
          };
          DisablePocket = true;
          DisableFirefoxAccounts = true;
          DisableAccounts = true;
          DisableFirefoxScreenshots = true;
          OverrideFirstRunPage = "";
          OverridePostUpdatePage = "";
          DontCheckDefaultBrowser = true;
          DisplayBookmarksToolbar = "never"; # alternatives: "always" or "newtab"
          DisplayMenuBar = "default-off"; # alternatives: "always", "never" or "default-on"
          SearchBar = "unified"; # alternative: "separate"

          /* ---- EXTENSIONS ---- */
          # Check about:support for extension/add-on ID strings.
          # Valid strings for installation_mode are "allowed", "blocked",
          # "force_installed" and "normal_installed".
          ExtensionSettings = {
            "*".installation_mode = "blocked"; # blocks all addons except the ones specified below
            "uBlock0@raymondhill.net" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
              installation_mode = "force_installed";
            };
            "sponsorBlocker@ajay.app" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
              installation_mode = "force_installed";
            };
            "tridactyl.vim@cmcaine.co.uk" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/tridactyl-vim/latest.xpi";
              installation_mode = "force_installed";
            };
            # "{d7742d87-e61d-4b78-b8a1-b469842139fa}" = {
            #   install_url = "https://addons.mozilla.org/firefox/downloads/latest/vimium-ff/latest.xpi";
            #   installation_mode = "force_installed";
            # };
            "deArrow@ajay.app" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/dearrow/latest.xpi";
              installation_mode = "force_installed";
            };
            "{58204f8b-01c2-4bbc-98f8-9a90458fd9ef}" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/blocktube/latest.xpi";
              installation_mode = "force_installed";
            };
            "addon@darkreader.org" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
              installation_mode = "force_installed";
            };
            "{762f9885-5a13-4abd-9c77-433dcd38b8fd}" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/return-youtube-dislikes/latest.xpi";
              installation_mode = "force_installed";
            };
          };

          /* ---- PREFERENCES ---- */
          # Check about:config for options.
          Preferences =
            let
              lock = x: { Value = x; Status = "locked"; };
            in {
              "geo.enabled" = lock false;
              "network.dns.disablePrefetch" = lock true;
              "network.prefetch-next" = lock false;
              "browser.menu.showViewImageInfo" = lock true;
              "browser.fullscreen.autohide" = lock false;

              "browser.contentblocking.category" = lock "strict";
              "extensions.pocket.enabled" = lock false;
              "extensions.screenshots.disabled" = lock true;
              "browser.topsites.contile.enabled" = lock false;
              "browser.formfill.enable" = lock false;
              "browser.search.suggest.enabled" = lock false;
              "browser.search.suggest.enabled.private" = lock false;
              "browser.urlbar.suggest.searches" = lock false;
              "browser.urlbar.showSearchSuggestionsFirst" = lock false;
              "browser.newtabpage.activity-stream.feeds.section.topstories" = lock false;
              "browser.newtabpage.activity-stream.feeds.snippets" = lock false;
              "browser.newtabpage.activity-stream.section.highlights.includePocket" = lock false;
              "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = lock false;
              "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = lock false;
              "browser.newtabpage.activity-stream.section.highlights.includeVisited" = lock false;
              "browser.newtabpage.activity-stream.showSponsored" = lock false;
              "browser.newtabpage.activity-stream.system.showSponsored" = lock false;
              "browser.newtabpage.activity-stream.showSponsoredTopSites" = lock false;
            };
        };
      };
    };
  };
}
