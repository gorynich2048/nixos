{
  networking.nat = {
    enable = true;
    internalIPs = [ "10.0.0.0/24" ];
  };
  networking.firewall.allowedUDPPorts = [ 62048 ];

  networking.wireguard.interfaces = {
    wg0 = {
      ips = [ "10.0.0.1/24" ];
      listenPort = 62048;

      peers = [
        {
          publicKey = "/4GA4n7riAxw0ffnegSUrfx2Xz98HTU49zSfKCwuEh0=";
          allowedIPs = [ "10.0.0.2/32" ];
        }
        {
          publicKey = "bfr3Q/hkv9oJ4kzcQ9cvwVKxeHiyPo9tRRO+ETAEoxo=";
          allowedIPs = [ "10.0.0.3/32" ];
        }
      ];
    };
  };
}
