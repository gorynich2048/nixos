{ ... }: {
  networking.wireguard.interfaces.wg0 = {
    type = "amneziawg";
    extraOptions = {
      H4 = 12345;
      Jc = 5;
      Jmax = 42;
      Jmin = 10;
      S1 = 60;
      S2 = 90;
    };
  };
}
