{ nixos-wsl, ... }: {
  imports = [
    nixos-wsl.nixosModules.default
    ../../remote
    ./programs.nix
    ./services.nix
  ];

  wsl = {
    enable = true;
    defaultUser = "user";
  };

  networking = {
    hostName = "wsl";
  };
}
