{ modulesPath, ... }: {
  imports = [
    (modulesPath + "/profiles/minimal.nix")
    ../../remote
    ./programs.nix
    ./services.nix
  ];

  boot.isContainer = true;
  nix.settings.sandbox = false;

  networking.hostName = "host";
}
