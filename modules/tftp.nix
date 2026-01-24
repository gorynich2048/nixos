{
  # Uses /srv/tftp/
  services.tftpd.enable = true;
  networking.firewall.allowedUDPPorts = [ 69 ];
}
