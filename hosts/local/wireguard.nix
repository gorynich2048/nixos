{ pkgs, ... }: {
  imports = [
    ../../modules/wireguard
  ];

  networking.wireguard.interfaces.wg0 = {
    ips = [ "10.0.0.2/24" ];
    listenPort = 62048;
    # socketNamespace = "wg";

    peers = [
      {
        publicKey = "R4EpoMFIg5mEz9+lTGJwbnC24ySQSvkv8S0DXPZazxE=";
        allowedIPs = [ "0.0.0.0/0" ];
        endpoint = "176.9.86.158:51000";
        persistentKeepalive = 25;
      }
    ];
  };

  systemd.services = {
    wg-ns = {
      requiredBy = [ "network-pre.target" ];
      serviceConfig = let
        ip = "${pkgs.iproute2}/bin/ip";
      in {
        Type = "oneshot";
        RemainAfterExit = "yes";
        ExecStart = pkgs.writers.writeBash "wg-ns-up" ''
          # ${ip} netns add wg
          # ${ip} link add link enp4s0 name en0 netns wg type macvlan
          # ${ip} -n wg link set en0 up
          # ${ip} -n wg addr add 192.168.1.200/24 dev en0
          # ${ip} -n wg route add 176.9.86.158 via 192.168.1.1
          ${ip} route add 176.9.86.158 via 192.168.1.1
        '';
        ExecStop = pkgs.writers.writeBash "wg-ns-down" ''
          # ${ip} netns del wg
          ${ip} route del 176.9.86.158 via 192.168.1.1
        '';
      };
    };
  };
}
