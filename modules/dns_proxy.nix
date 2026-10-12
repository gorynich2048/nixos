{
  networking = {
    firewall.allowedTCPPorts = [ 53 ];
    firewall.allowedUDPPorts = [ 53 ];
    nat.extraCommands = ''
      iptables -A PREROUTING -t nat -p tcp --dport 53 -j DNAT --to-destination 1.1.1.1:53
      iptables -A PREROUTING -t nat -p udp --dport 53 -j DNAT --to-destination 1.1.1.1:53
    '';
    nat.extraStopCommands = ''
      iptables -D PREROUTING -t nat -p tcp --dport 53 -j DNAT --to-destination 1.1.1.1:53 || true
      iptables -D PREROUTING -t nat -p udp --dport 53 -j DNAT --to-destination 1.1.1.1:53 || true
    '';
  };
}
