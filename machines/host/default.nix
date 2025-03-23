{ disko, ... }: {
  imports = [
    ../../modules/shared
    ../../modules/remote
    ../../modules/kvm

    disko.nixosModules.disko
    ./disk-config.nix
    ./hardware-configuration.nix
    ./services.nix
  ];

  boot.loader.grub = {
    device = "/dev/nvme0n1";
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  networking = {
    hostName = "host";
    useDHCP = false;
  };

  systemd.network = {
    enable = true;
    networks."10-eth0" = {
      matchConfig.Name = "enp*";
      address = [
        "176.9.86.158/27"
        "2a01:4f8:151:2484::2/64"
      ];
      routes = [
        {
          Destination = "0.0.0.0/0";
          Gateway = "176.9.86.129";
          GatewayOnLink = true;
        }
        {
          Destination = "::/0";
          Gateway = "fe80::1";
          GatewayOnLink = true;
        }
      ];
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
