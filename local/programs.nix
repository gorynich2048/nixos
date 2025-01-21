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
        vscode-extensions.ms-vscode.cpptools = prev.vscode-extensions.ms-vscode.cpptools.overrideAttrs(oldAttrs: {
          postFixup = (oldAttrs.postFixup or "") + ''
            cp $out/share/vscode/extensions/ms-vscode.cpptools/debugAdapters/bin/cppdbg.ad7Engine.json $out/share/vscode/extensions/ms-vscode.cpptools/debugAdapters/bin/nvim-dap.ad7Engine.json
          '';
        });
      })
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

      kitty
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
  };

  home-manager.users.user = {
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
  };
  
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };
}
