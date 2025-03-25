{ pkgs, ... }: {
  imports = [
    ./amnezia.nix
    ./genkey.nix
  ];

  networking.nat.enable = true;
  networking.nat.externalInterface = "eth0";
  networking.nat.internalInterfaces = [ "wg0" ];
  networking.firewall.allowedUDPPorts = [ 62048 ];

  networking.wireguard.enable = true;
  networking.wireguard.interfaces = {
    wg0 = {
      ips = [ "10.100.0.1/24" ];
      listenPort = 62048;

      # This allows the wireguard server to route your traffic to the internet and hence be like a VPN
      # For this to work you have to set the dnsserver IP of your router (or dnsserver of choice) in your clients
      postSetup = ''
        ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.100.0.0/24 -o eth0 -j MASQUERADE
      '';

      postShutdown = ''
        ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.100.0.0/24 -o eth0 -j MASQUERADE
      '';

      peers = [
        {
          publicKey = "/4GA4n7riAxw0ffnegSUrfx2Xz98HTU49zSfKCwuEh0=";
          allowedIPs = [ "10.100.0.2/32" ];
        }
      ];
    };
  };
}
