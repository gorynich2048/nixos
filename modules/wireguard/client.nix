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
      socketNamespace = "wg";

      peers = [
        {
          publicKey = "R4EpoMFIg5mEz9+lTGJwbnC24ySQSvkv8S0DXPZazxE=";
          allowedIPs = [ "0.0.0.0/0" ];
          endpoint = "176.9.86.158:51000";
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
