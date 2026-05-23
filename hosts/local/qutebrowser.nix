{ pkgs, ... }: {
  home-manager.users.user = {
    programs = {
      qutebrowser = {
        enable = true;
        loadAutoconfig = true;
        keyBindings = {
          normal = {
            "<Ctrl-i>" = "forward";
            "<Ctrl-o>" = "back";
            F = "hint links run open -t {hint-url}";
            H = "tab-next";
            L = "tab-prev";
            P = "open -t -- {clipboard}";
            b = "cmd-set-text -sr :tab-focus";
            f = "hint links run open {hint-url}";
            h = "scroll-page 0 0.5";
            j = "tab-next";
            k = "tab-prev";
            l = "scroll-page 0 -0.5";
            p = "open -- {clipboard}";
          };
        };
        settings = {
          colors = {
            webpage.darkmode.enabled = true;
            hints = {
              bg = "#1f1f1f";
              fg = "#007fff";
            };
          };
          content.autoplay = false;
          hints = {
            border = "none";
            chars = "hetisngploradumycfbw";
            radius = 0;
          };
          tabs.show = "never";
          fonts.default_size = "12pt";
          zoom.default = 140;
        };
        searchEngines.DEFAULT = "https://www.google.com/search?q={}";
      };
    };
  };

  environment.sessionVariables.DEFAULT_BROWSER = "${pkgs.qutebrowser}/bin/qutebrowser";
  xdg.mime.enable = true;
  xdg.mime.defaultApplications = {
    "text/html" = "org.qutebrowser.qutebrowser.desktop";
    "x-scheme-handler/http" = "org.qutebrowser.qutebrowser.desktop";
    "x-scheme-handler/https" = "org.qutebrowser.qutebrowser.desktop";
    "x-scheme-handler/about" = "org.qutebrowser.qutebrowser.desktop";
    "x-scheme-handler/unknown" = "org.qutebrowser.qutebrowser.desktop";
  };
}
