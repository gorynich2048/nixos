{ modulesPath, ... }: {
  imports = [
    ../../remote
    ./../../nspawn/configuration.nix
    ./programs.nix
    ./services.nix
    ./wireguard.nix
  ];

  networking.hostName = "host";
}
