{ pkgs, ... }: {
  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;
    };
    zerotierone = {
      enable = true;
      joinNetworks = [ "3efa5cb78ac3e597" "17d709436cba1f72" ];
    };
    davmail = {
      enable = true;
      url = "https://mail.parascript.com/EWS/Exchange.asmx";
      config = {
        davmail.mode = "EWS";
      };
    };
    # hydra = {
    #   enable = true;
    #   hydraURL = "http://localhost:3000"; # externally visible URL
    #   notificationSender = ""; # e-mail of hydra service
    #   # a standalone hydra will require you to unset the buildMachinesFiles list to avoid using a nonexistant /etc/nix/machines
    #   buildMachinesFiles = [];
    #   # you will probably also want, otherwise *everything* will be built from scratch
    #   useSubstitutes = true;
    # };
    # static-web-server = {
    #   enable = true;
    #   listen = "[::]:80";
    #   root = "/srv";
    #   configuration.general.directory-listing = true;
    # };
    # lighttpd = {
    #   enable = true;
    #   document-root = "/";
    #   extraConfig = ''
    #     server.dir-listing = "enable"
    #   '';
    # };
  };

  systemd = {
    services = {
      # wireproxy = {
      #   wantedBy = [ "multi-user.target" ];
      #   serviceConfig = {
      #     ExecStart =
      #       "${pkgs.wireproxy}/bin/wireproxy -s -c /home/user/wg/wireguard.conf";
      #     # User = "wireproxy";
      #   };
      # };
    };
    user.services = {
      alsa-restore = {
         wantedBy = [ "default.target" ];
         wants = [ "pipewire.service" ];
         serviceConfig = {
           ExecStartPre = "${pkgs.coreutils-full}/bin/sleep 5";
           ExecStart = "${pkgs.alsa-utils}/bin/alsactl restore -L";
         };
      };
    };
  };

  # Enable the X11 windowing system.
  #services.xserver.enable = true;

  # Enable the Plasma 5 Desktop Environment.
  #services.xserver.displayManager.sddm.enable = true;
  #services.xserver.desktopManager.plasma5.enable = true;

  # Configure keymap in X11
  # services.xserver = {
  #   enable = true;

  #   xkb = {
  #     layout = "us,ru";
  #     options = "grp:alt_shift_toggle";
  #   };

  #   displayManager = {
  #     # defaultSession = "none+i3";
  #     sddm.enable = true;
  #     defaultSession = "plasmawayland";
  #     setupCommands = ''
  #       ${pkgs.xorg.xrandr}/bin/xrandr --output DP-2 --primary
  #     '';
  #   };

  #   desktopManager.plasma5.enable = true;

  #   windowManager.i3 = {
  #     enable = true;
  #     extraPackages = with pkgs; [ dmenu i3status ];
  #   };

  #   libinput = {
  #     enable = true;

  #     # disabling mouse acceleration
  #     mouse = { accelProfile = "flat"; };
  #   };

  #   excludePackages = with pkgs; [ xterm ];
  # };
}
