{ lib, pkgs, ... }: {
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "nvidia-x11"
      "nvidia-settings"
      "steam"
      "steam-original"
      "steam-run"
    ]
    || builtins.match "^cudatoolkit-.*" (lib.getName pkg) != [];

  environment = {
    systemPackages = with pkgs; [
      sshfs
      nmap
      android-file-transfer
      wineWow64Packages.waylandFull
      winetricks
      mpv
      yt-dlp
      wireguard-tools

      chromium
      easyeffects
      krita
      blender
      remmina
      discord-canary
      koboldcpp
    ];
  };

  programs = {
    steam = {
      enable = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };
    # use 'gamemoderun %command%' in steam params
    gamemode.enable = true;
  };

  home-manager.users.user = {
    home.packages = [ pkgs.jetbrains-mono ];
    programs = {
      kitty = {
        enable = true;
        settings = {
          background_opacity = 0; # 0.8;
          background = "#1f1f1f";
          input_delay = 0;
          repaint_delay = 8;
          sync_to_monitor = "no";
          wayland_enable_ime = "no";
        };
        extraConfig = ''
          font_family full_name="JetBrains Mono SemiBold"
          disable_ligatures always
          modify_font cell_height 90%
          modify_font baseline 1px
          font_size 14
        '';
      };

      zathura = {
        enable = true;
        mappings = {
          "l" = "scroll half-up";
          "h" = "scroll half-down";
        };
        options = {
          recolor = true;
          recolor-darkcolor = "#ffffff";
          recolor-lightcolor = "#1f1f1f";
        };
      };
    };
  };
}
