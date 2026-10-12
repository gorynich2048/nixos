{
  services.resolved.enable = false;
  networking.dhcpcd.extraConfig = "nohook resolv.conf";
  networking.nameservers = [ "1.1.1.1" "8.8.8.8" ];
}
