{ ... }: {
  imports = [
    ./amnezia.nix
    ./genkey.nix
  ];

  networking.wireguard.enable = true;
  networking.wireguard.interfaces = {
    wg0 = {
      ips = [ "10.0.0.2/24" ];
      listenPort = 62048;

      peers = [
        {
          publicKey = "EaxYgX3D0spYPVtGShmGalcWqafM9Xd86mmj6xCaXBQ=";
          allowedIPs = [ "0.0.0.0/0" ];
          endpoint = "176.9.86.158:1000";
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
