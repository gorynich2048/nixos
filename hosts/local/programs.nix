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
      wineWowPackages.waylandFull
      winetricks
      mpv
      yt-dlp
      wireguard-tools

      chromium
      easyeffects
      krita
      blender
      remmina
    ];
  };

  programs = {
    steam = {
      enable = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };
  };

  home-manager.users.user = {
    home.packages = [ pkgs.jetbrains-mono ];
    programs = {
      kitty = {
        enable = true;
        settings = {
          background_opacity = 0; # 0.8;
          background = "#1f1f1f";
        };
        extraConfig = ''
          font_family full_name="JetBrains Mono Bold"
          disable_ligatures always
          modify_font cell_height 90%
          modify_font baseline 1px
          font_size 12
        '';
      };
    };
  };
}
