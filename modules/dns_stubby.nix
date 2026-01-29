{ pkgs, ... }: {
  networking = {
    nameservers = [ "127.0.0.1" "::1" ];
    firewall.allowedUDPPorts = [ 53 ];
    dhcpcd.extraConfig = "nohook resolv.conf";
  };
  services.resolved.enable = false;
  services.stubby = {
    enable = true;
    settings = pkgs.stubby.passthru.settingsExample // {
      listen_addresses = [ "0.0.0.0" ];
    };
  };
}
