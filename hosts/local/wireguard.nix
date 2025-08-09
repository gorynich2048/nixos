{ pkgs, ... }: {
  imports = [
    ../../modules/wireguard
  ];

  networking.wireguard.interfaces.wg0 = {
    ips = [ "10.0.0.2/24" ];
    listenPort = 62048;

    peers = [
      {
        publicKey = "zA9yoGWL6UUeGDKjTO2fhV0/006uWeuUE2yaEiRAJSo=";
        allowedIPs = [ "0.0.0.0/0" ];
        endpoint = "138.201.221.18:51000";
        persistentKeepalive = 25;
      }
    ];
  };

  systemd.services = {
    wireguard-route = {
      requiredBy = [ "multi-user.target" ];
      requires = [ "network-online.target" ];
      path = with pkgs; [ iproute2 ];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = "yes";
      };
      script = ''
        ip route add 138.201.221.18 via 192.168.1.1 || true
      '';
    };
  };
}
