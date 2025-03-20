{ modulesPath, ... }: {
  imports = [
    ../../remote
    ./../../nspawn/configuration.nix
    ./programs.nix
    ./services.nix
  ];

  networking.hostName = "host";
}
