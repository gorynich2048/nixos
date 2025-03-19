{ modulesPath, ... }: {
  imports = [
    (modulesPath + "/profiles/minimal.nix")
    ../../remote
    ./../../nspawn/nspawn-image.nix
    ./programs.nix
    ./services.nix
  ];

  boot.isContainer = true;
  nix.settings.sandbox = false;

  networking.hostName = "host";
}
