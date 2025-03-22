{ ... }: {
  imports = [
    ../../modules/shared
    ../../modules/remote
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "vpn";
  };

  virtualisation.vmVariant = {
    systemd.network = {
      enable = true;
      networks."10-eth" = {
        matchConfig.Type = "ether";
        # matchConfig.MACAddress = "52:55:00:d1:55:01";
        networkConfig = {
          Address = [ "192.168.100.2/24" ];
          Gateway = "192.168.100.1";
          DHCP = "no";
        };
      };
    };
    virtualisation = {
      graphics = false;
      qemu.networkingOptions = [
        "-netdev tap,id=nd0,ifname=tap0,script=no,downscript=no"
        "-device virtio-net-pci,netdev=nd0,mac=52:55:00:d1:55:01"
      ];
    };
  };
  users.users.root.password = "test";

  system.stateVersion = "24.05"; # NEVER CHANGE
  home-manager = {
    users.root.home.stateVersion = "24.05"; # NEVER CHANGE
    backupFileExtension = "backup";
  };
}
