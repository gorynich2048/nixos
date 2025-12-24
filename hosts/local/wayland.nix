{ pkgs, rose-pine-hyprcursor, ... }: {
  programs.dconf.enable = true;

  home-manager.users.user = {
    wayland.windowManager.hyprland = {
      enable = true;
      extraConfig = builtins.readFile ./hyprland.conf;
    };

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

  environment = {
    systemPackages = with pkgs; [
      wofi
      grimblast
      wl-clipboard
      rose-pine-hyprcursor.packages.${stdenv.hostPlatform.system}.default
    ];
  };

  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };
}
