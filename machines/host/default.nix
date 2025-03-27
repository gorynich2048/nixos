{
  imports = [
    ../../modules/shared
    ../../modules/remote
    ../../modules/kvm

    ./disk-config.nix
    ./hardware-configuration.nix
    ./services.nix
  ];

  boot.loader.grub = {
    # Next time try to omit this and install boot loader on both drives, disko should generate this
    device = "/dev/nvme0n1";
    efiSupport = true;
    efiInstallAsRemovable = true;
    configurationLimit = 10;
  };

  networking = {
    hostName = "host";
    useDHCP = false;

    nat.externalInterface = "enp7s0";
    nat.forwardPorts = [
      {
        destination = "192.168.100.1:22";
        proto = "tcp";
        sourcePort = 1000;
      }
      {
        destination = "192.168.100.1:62048";
        proto = "udp";
        sourcePort = 1000;
      }
    ];
  };

  systemd.network = {
    enable = true;
    networks."0-enp" = {
      matchConfig.Name = "enp*";
      DHCP = "yes";
      linkConfig.RequiredForOnline = "routable";
    };
  };

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAr87Ijv/4gAllpnZrhaQZhW+iI/HzAMEjaxFsbrA91L continue"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIke/35rx1Hemk61WLo9CtGkrsKfVsgcerFgXZpmpkdf ragamaffin"
  ];

  system.stateVersion = "24.05"; # NEVER CHANGE
  home-manager = {
    users.root.home.stateVersion = "24.05"; # NEVER CHANGE
    backupFileExtension = "backup";
  };
}
