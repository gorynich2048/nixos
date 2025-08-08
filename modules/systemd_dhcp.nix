{
  networking = {
    useDHCP = false;
  };

  systemd.network = {
    enable = true;
    networks."0-en" = {
      matchConfig.Name = "en*";
      DHCP = "yes";
      linkConfig.RequiredForOnline = "routable";
    };
  };
}
