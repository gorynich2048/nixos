{ ... }: {
  imports = [
    ../../modules/shared
    ../../modules/dev
    ../../modules/kvm
    ../../modules/wireguard/client.nix

    ./hardware-configuration.nix
    ./programs.nix
    ./services.nix
    ./nvidia.nix
    ./wireguard-ns.nix
  ];

  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 10;
    };
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "local";
    extraHosts = ''
      130.61.52.25 xcore1
      176.9.86.158 host
    '';
    useDHCP = false;
  };

  systemd.network = {
    enable = true;
    networks."0-enp" = {
      matchConfig.Name = "enp*";
      DHCP = "yes";
      linkConfig.RequiredForOnline = "routable";
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
