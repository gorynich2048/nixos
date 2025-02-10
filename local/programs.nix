{ lib, pkgs, ... }@inputs: {
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "nvidia-x11"
      "nvidia-settings"
      "steam"
      "steam-original"
      "steam-run"
      "zerotierone"
    ]
    || builtins.match "^cudatoolkit-.*" (lib.getName pkg) != [];

  nixpkgs.overlays =
    [
      (final: prev: {
        vimPlugins = prev.vimPlugins // {
          cmake-tools-nvim = prev.vimPlugins.cmake-tools-nvim.overrideAttrs(oldAttrs: {
            src = prev.fetchFromGitHub {
              owner = "Civitasv";
              repo = "cmake-tools.nvim";
              rev = "aedf4b6c9b76294ec96ff617db7ffdfa634cfa69";
              sha256 = "sha256-umUzS4Tq9IEL3zt0ru6T7yPco4KfMgraSjIEMa/6BvQ=";
            };
          });
        };
      })
    ];

  environment = {
    systemPackages = with pkgs; [
      sshfs
      nmap
      android-file-transfer
      alsa-utils
      grimblast
      tesseract
      wl-clipboard
      wineWowPackages.waylandFull
      winetricks
      xdragon
      mangohud
      ollama
      mpv
      yt-dlp
      shadowsocks-rust
      openconnect

      qutebrowser
      chromium
      pavucontrol
      easyeffects
      wofi
      krita
      prismlauncher
      inputs.rose-pine-hyprcursor.packages.${system}.default
      remmina
    ];
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

  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    steam = {
      enable = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };

    nixvim = {
      clipboard.register = "unnamedplus";
      keymaps = let
        normal =
          lib.mapAttrsToList (key: action: {
            mode = "n";
            inherit action key;
          }) {
            "p" = "\"+p";
            "P" = "\"+P";
          };
        visual =
          lib.mapAttrsToList (key: action: {
            mode = "v";
            inherit action key;
          }) {
            "<leader>p" = "\"_d\"+P";
            "p" = "\"+p";
            "P" = "\"+P";
          };
        insert =
          lib.mapAttrsToList (key: action: {
            mode = "!";
            inherit action key;
          }) {
            "<C-v>" = "<C-r>+";
          };
        terminal =
          lib.mapAttrsToList (key: action: {
            mode = "t";
            inherit action key;
          }) {
            "<C-v>" = "<C-\\><C-o>\"+p";
          };
      in
        (normal ++ visual ++ insert ++ terminal);
    };
  };

  home-manager.users.user = {
    imports = [
      ../shared/btop.nix
    ];

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };

    gtk = {
      enable = true;
      theme = {
        name = "Adwaita-dark";
        package = pkgs.gnome-themes-extra;
      };
    };

    programs = {
      kitty = {
        enable = true;
        settings = {
          background_opacity = 0; # 0.8;
          background = "#1f1f1f";
        };
      };
    };
  };
  
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };
}
