{ lib, ... }: {
  imports = [
    ../../modules/shared
    ../../modules/remote
  ];

  networking = {
    hostName = "vpn";
  };

  virtualisation.vmVariant = let
    index = 1;
    mac = "00:00:00:00:00:01";
  in {
    networking.useDHCP = false;
    systemd.network = {
      enable = true;
      networks."10-eth" = {
        matchConfig.MACAddress = mac;
        address = [
          "192.168.100.${toString index}/32"
          "fec0::${lib.toHexString index}/128"
        ];
        routes = [
          {
            # A route to the host
            Destination = "192.168.100.0/32";
            GatewayOnLink = true;
          }
          {
            # Default route
            Destination = "0.0.0.0/0";
            Gateway = "192.168.100.0";
            GatewayOnLink = true;
          }
          {
            # Default route
            Destination = "::/0";
            Gateway = "fec0::";
            GatewayOnLink = true;
          }
        ];
        linkConfig.RequiredForOnline = "routable";
      };
    };
    virtualisation = {
      graphics = false;
      qemu.networkingOptions = lib.mkForce [
        "-netdev tap,id=nd0,ifname=vm${toString index},script=no,downscript=no"
        "-device virtio-net-pci,netdev=nd0,mac=${mac}"
      ];
    };
  };

  system.stateVersion = "24.05"; # NEVER CHANGE
  home-manager = {
    users.root.home.stateVersion = "24.05"; # NEVER CHANGE
    backupFileExtension = "backup";
  };
}
