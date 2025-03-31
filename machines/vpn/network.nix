{ lib, ... }:
let
  index = 1;
  mac = "00:00:00:00:00:01";
in {
  networking = {
    hostName = "vpn";
    useDHCP = false;
  };

  systemd.network = {
    enable = true;
    networks."10-eth" = {
      matchConfig.MACAddress = mac;
      address = [
        "192.168.100.${toString index}/32"
        "fec0::${lib.toHexString index}/128"
      ];
      routes = [
        {
          Destination = "192.168.100.0/32";
          GatewayOnLink = true;
        }
        {
          Destination = "0.0.0.0/0";
          Gateway = "192.168.100.0";
          GatewayOnLink = true;
        }
        {
          Destination = "::/0";
          Gateway = "fec0::";
          GatewayOnLink = true;
        }
      ];
    };
  };

  virtualisation.vmVariantWithBootLoader.virtualisation = {
    qemu.networkingOptions = lib.mkForce [
      "-nic tap,script=no,downscript=no,vhost=on,model=virtio-net-pci,ifname=vm${toString index},mac=${mac}"
    ];
  };
}
