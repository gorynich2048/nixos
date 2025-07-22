{
  networking = {
    useDHCP = false;
  };

  systemd.network = {
    enable = true;
    networks."0-enp" = {
      matchConfig.Name = "enp*";
      DHCP = "yes";
      linkConfig.RequiredForOnline = "routable";
    };
  };
}
