{ nixos-wsl, ... }: {
  imports = [
    ./programs.nix
    ./services.nix
    ../shared
    nixos-wsl.nixosModules.default
  ];

  wsl = {
    enable = true;
    defaultUser = "user";
  };

  networking = {
    hostName = "wsl";
  };
}
