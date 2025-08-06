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
      after = [ "network-online.target" ];
      serviceConfig = let
        ip = "${pkgs.iproute2}/bin/ip";
      in {
        Type = "oneshot";
        RemainAfterExit = "yes";
        ExecStart = pkgs.writers.writeBash "wg-up" ''
          ${ip} route add 138.201.221.18 via 192.168.1.1
        '';
        ExecStop = pkgs.writers.writeBash "wg-down" ''
          ${ip} route del 138.201.221.18 via 192.168.1.1
        '';
      };
    };
  };
}
