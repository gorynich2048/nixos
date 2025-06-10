{ ... }: {
  networking.wireguard.interfaces.wg0 = {
    type = "amneziawg";
    extraOptions = {
      H4 = 2048;
      Jc = 4;
      Jmax = 32;
      Jmin = 16;
      S1 = 16;
      S2 = 17;
    };
  };
}
