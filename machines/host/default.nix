{ ... }: {
  imports = [
    ./programs.nix
    ./services.nix
    ../../remote
  ];

  networking = {
    hostName = "host";
  };
}
