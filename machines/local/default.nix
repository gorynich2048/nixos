{ ... }: {
  imports = [
    ../../modules/shared
    ../../modules/dev

    ./hardware-configuration.nix
    ./programs.nix
    ./services.nix
    ./nvidia.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "local";
    extraHosts = ''
      130.61.52.25 xcore1
      176.9.86.158 host
    '';
    nat = {
      enable = true;
      internalIPs = [ "192.168.100.0/24" ];
      externalInterface = "enp4s0";
    };
  };

  systemd.network = {
    enable = true;
    netdevs = {
      "10-br0" = {
        netdevConfig = {
          Kind = "bridge";
          Name = "br0";
        };
      };
    };
    networks = {
      "20-taps" = {
        matchConfig.Name ="tap*";
        networkConfig = {
          Bridge = "br0";
        };
      };
      "20-br0" = {
        matchConfig.Name = "br0";
        networkConfig = {
          Address = [ "192.168.100.1/24" ];
        };
      };
    };
  };

  security.rtkit.enable = true;

  system.stateVersion = "23.11"; # NEVER CHANGE
  home-manager = {
    users.user.home.stateVersion = "23.11"; # NEVER CHANGE
    users.root.home.stateVersion = "23.11"; # NEVER CHANGE
    backupFileExtension = "backup";
  };
}
