{ modulesPath, ... }: {
  imports = [
    (modulesPath + "/profiles/minimal.nix")
    ./nspawn-image.nix
  ];

  boot.isContainer = true;
  networking.hostName = "nspawn";

  nix = {
    settings.sandbox = false;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  system.stateVersion = "23.11";
}
