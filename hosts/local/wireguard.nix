{ pkgs, ... }: {
  imports = [
    ../../modules/wireguard
  ];

  networking.wireguard.interfaces.wg0 = {
    ips = [ "10.0.0.2/24" ];
    listenPort = 51002;
    # socketNamespace = "wg";

    peers = [
      {
        publicKey = "pF+oEqRsnjt7t7F6k7QOONGb4/DCBQQjpSaVjf6CgWI=";
        allowedIPs = [ "0.0.0.0/0" ];
        endpoint = "10.2.0.1:51002";
        persistentKeepalive = 25;
      }
    ];
  };

  systemd.services = {
    wireguard-route = {
      wantedBy = [ "multi-user.target" ];
      after = [ "network-online.target" ];
      requires = [ "network-online.target" ];
      path = with pkgs; [ iproute2 ];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = "yes";
      };
      script = ''
        ip route add 10.2.0.1 via 192.168.1.1
        ip route add 138.201.221.18 via 192.168.1.1
      '';
    };

    # wireguard-ns = {
    #   requiredBy = [ "network-pre.target" ];
    #   path = with pkgs; [ iproute2 ];
    #   serviceConfig = {
    #     Type = "oneshot";
    #     RemainAfterExit = "yes";
    #   };
    #   script = ''
    #     ip netns add wg
    #     ip link add link enp4s0 name en0 netns wg type macvlan
    #     ip -n wg link set en0 up
    #     ip -n wg addr add 192.168.1.200/24 dev en0
    #     ip -n wg route add 138.201.221.18 via 192.168.1.1
    #   '';
    # };
  };
}
