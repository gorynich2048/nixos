{
  imports = [
    ./amnezia.nix
    ./genkey.nix
  ];

  networking.wireguard.enable = true;
}
