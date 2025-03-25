{ ... }: {
  imports = [
    ./kernel.nix
    ./genkey.nix
  ];

  networking.firewall.allowedUDPPorts = [ 62048 ];
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
          ListenPort = 62048;
          RouteTable = "main";
        };
        wireguardPeers = [
          {
            PublicKey = "/4GA4n7riAxw0ffnegSUrfx2Xz98HTU49zSfKCwuEh0=";
            AllowedIPs = ["10.100.0.2"];
          }
        ];
      };
    };
    networks.wg0 = {
      matchConfig.Name = "wg0";
      address = ["10.100.0.1/24"];
      networkConfig = {
        IPMasquerade = "ipv4";
      };
    };
  };
}
