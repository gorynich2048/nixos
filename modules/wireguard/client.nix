{ ... }: {
  imports = [
    ./amnezia.nix
    ./genkey.nix
  ];

  networking.wireguard.enable = true;
  networking.wireguard.interfaces.wg0 = {
    listenPort = 62048;
  };
}
