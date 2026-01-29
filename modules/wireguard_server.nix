{
  networking.nat = {
    enable = true;
    internalIPs = [ "10.0.0.0/24" ];
  };
  networking.firewall.allowedUDPPorts = [ 51002 ];

  networking.wireguard.interfaces = {
    wg0 = {
      ips = [ "10.0.0.1/24" ];
      listenPort = 51002;

      peers = [
        {
          publicKey = "LDbgVEle8hzKinuYQHuvqAA9pukPi/4jTbsAewHj5Q4=";
          allowedIPs = [ "10.0.0.2/32" ];
        }
        {
          publicKey = "TSeUFJiXA3oLDkm+g8opWEM/xSdiAann/WXlfGaDZS8=";
          allowedIPs = [ "10.0.0.3/32" ];
        }
      ];
    };
  };
}
