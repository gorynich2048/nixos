{ nixos-wsl, ... }: {
  imports = [
    ./programs.nix
    ./services.nix
  ];
}
