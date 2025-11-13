{ lib, pkgs, ... }:
let
  index = 1;
  mac = "00:00:00:00:00:01";
in {
  networking = {
    hostName = "lab";
    useDHCP = false;
    nat = {
      enable = true;
      internalIPs = [ "10.0.0.0/8" ];
    };
  };

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
          Destination = "192.168.100.0/32";
          GatewayOnLink = true;
        }
        {
          Destination = "0.0.0.0/0";
          Gateway = "192.168.100.0";
          GatewayOnLink = true;
        }
        {
          Destination = "::/0";
          Gateway = "fec0::";
          GatewayOnLink = true;
        }
      ];
      # tunnel = [ "gre0" ];
    };

    # netdevs."20-gre" = {
    #   enable = true;
    #   netdevConfig = {
    #     Kind = "gre";
    #     Name = "gre0";
    #     MTUBytes = 1480;
    #   };
    #   tunnelConfig = {
    #     Remote = "85.93.44.80";
    #     Local = "192.168.100.1";
    #   };
    # };
    #
    # networks."20-gre" = {
    #   enable = true;
    #   matchConfig.Name = "gre0";
    #   address = [
    #     "10.2.0.1/30"
    #   ];
    #   linkConfig.RequiredForOnline = "no";
    # };

  };

  systemd.services = {
    gre = {
      wantedBy = [ "multi-user.target" ];
      after = [ "network-online.target" ];
      requires = [ "network-online.target" ];
      path = with pkgs; [ iproute2 ];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = "yes";
      };
      script = ''
        ip tunnel add gre1 mode gre local 192.168.100.1 remote 85.93.44.80
        ip addr add 10.2.0.1/30 dev gre1
        ip link set gre1 up
      '';
    };
  };

  networking.firewall.allowedTCPPortRanges = [
    { from = 51000; to = 51999; }
  ];
  networking.firewall.allowedUDPPortRanges = [
    { from = 51000; to = 51999; }
  ];

  virtualisation.vmVariantWithBootLoader.virtualisation = {
    qemu.networkingOptions = lib.mkForce [
      "-nic tap,script=no,downscript=no,vhost=on,model=virtio-net-pci,ifname=vm${toString index},mac=${mac}"
    ];
  };
}
