{ lib, ... }: {
  hardware.ksm.enable = true;

  networking.nat = {
    enable = true;
    internalIPs = [ "192.168.100.0/24" ];
  };

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
