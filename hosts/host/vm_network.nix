{ lib, ... }: {
  networking = {
    nat = {
      enable = true;
      # eth0 doesn't work here
      externalInterface = "enp0s31f6";
      internalIPs = [ "192.168.100.0/24" ];
    };

    # Forward ports
    nat.forwardPorts = let
      addCommon = n: [
        {
          destination = "192.168.100.${n}:22";
          proto = "tcp";
          sourcePort = lib.strings.toInt "5${n}000";
        }
        {
          destination = "192.168.100.${n}:5${n}001-5${n}999";
          proto = "tcp";
          sourcePort = "5${n}001:5${n}999";
        }
        {
          destination = "192.168.100.${n}:5${n}001-5${n}999";
          proto = "udp";
          sourcePort = "5${n}001:5${n}999";
        }
      ];
      maxVMs = 9;
    in lib.lists.flatten [
      (map (index: (addCommon (toString index)))
        (lib.genList (i: i + 1) maxVMs)
      )
    ];

    # Forward GRE
    nat = {
      extraCommands = ''
        iptables -A PREROUTING -t nat -p gre --src 92.255.229.156 -j DNAT --to-destination 192.168.100.3
        iptables -A POSTROUTING -t nat -p gre --src 192.168.100.3 -j SNAT --to-source 138.201.221.18
      '';
      extraStopCommands = ''
        iptables -D PREROUTING -t nat -p gre --src 92.255.229.156 -j DNAT --to-destination 192.168.100.3 || true
        iptables -D POSTROUTING -t nat -p gre --src 192.168.100.3 -j SNAT --to-source 138.201.221.18 || true
      '';
    };
  };

  # Configure host interfaces for vm's
  systemd.network = {
    enable = true;
    networks = let
      maxVMs = 9;
    in builtins.listToAttrs (
        map (index: {
          name = "10-vm${toString index}";
          value = {
            matchConfig.Name = "vm${toString index}";
            # Host's addresses
            address = [
              "192.168.100.0/32"
              "fec0::/128"
            ];
            # Setup routes to the VM
            routes = [
              { Destination = "192.168.100.${toString index}/32"; }
              { Destination = "fec0::${lib.toHexString index}/128"; }
            ];
            # Enable routing
            networkConfig = {
              IPv4Forwarding = true;
              IPv6Forwarding = true;
            };
          };
        }) (lib.genList (i: i + 1) maxVMs)
      );
  };
}
