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
        sourcePort = 51000;
      }
      {
        destination = "192.168.100.1:62048";
        proto = "udp";
        sourcePort = 51000;
      }
      {
        destination = "192.168.100.3:22";
        proto = "tcp";
        sourcePort = 53000;
      }
    ];
    nat.extraCommands = ''
      iptables -A PREROUTING -t nat -p gre --src 92.255.229.156 -j DNAT --to-destination 192.168.100.3
      iptables -A POSTROUTING -t nat -p gre --src 192.168.100.3 -j SNAT --to-source 176.9.86.158
    '';
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
