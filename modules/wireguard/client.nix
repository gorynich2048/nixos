{ ... }: {
  imports = [
    ./amnezia.nix
    ./genkey.nix
  ];

  networking.wireguard.enable = true;
  networking.wireguard.interfaces = {
    wg0 = {
      ips = [ "10.100.0.2/24" ];
      listenPort = 62048;

      peers = [
        {
          publicKey = "EaxYgX3D0spYPVtGShmGalcWqafM9Xd86mmj6xCaXBQ=";
          allowedIPs = [ "0.0.0.0/0" ];
          endpoint = "192.168.100.1:62048";
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
