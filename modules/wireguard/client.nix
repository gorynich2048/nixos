{ ... }: {
  imports = [
    ./kernel.nix
    ./genkey.nix
  ];

  systemd.network = {
    enable = true;
    netdevs = {
      "10-wg0" = {
        netdevConfig = {
          Kind = "wireguard";
          Name = "wg0";
          MTUBytes = "1300";
        };
        wireguardConfig = {
          PrivateKeyFile = "/var/wg/private";
          ListenPort = 62049;
        };
        wireguardPeers = [          
          {
            PublicKey = "EaxYgX3D0spYPVtGShmGalcWqafM9Xd86mmj6xCaXBQ=";
            AllowedIPs = ["fc00::1/64" "10.100.0.1"];
            Endpoint = "192.168.100.1:62048";
          }
        ];
      };
    };
    networks.wg0 = {
      matchConfig.Name = "wg0";
      address = [
        "fe80::3/64"
        "fc00::3/120"
        "10.100.0.2/24"
      ];
      DHCP = "no";
      dns = ["fc00::53"];
      ntp = ["fc00::123"];
      gateway = [
        "fc00::1"
        "10.100.0.1"
      ];
      networkConfig = {
        IPv6AcceptRA = false;
      };
    };
  };
}
