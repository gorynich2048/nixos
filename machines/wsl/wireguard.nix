{ ... }: {
  imports = [
    ../../modules/wireguard/client.nix
  ];

  networking.wireguard.interfaces.wg0 = {
    ips = [ "10.0.0.4/24" ];

    peers = [
      {
        publicKey = "R4EpoMFIg5mEz9+lTGJwbnC24ySQSvkv8S0DXPZazxE=";
        allowedIPs = [ "10.0.0.4/32" ];
        endpoint = "176.9.86.158:51000";
        persistentKeepalive = 25;
      }
    ];
  };
}
