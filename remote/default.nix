{ ... }: {
  imports = [
    ./hardware-configuration.nix
    ./programs.nix
    ./services.nix
    ../shared
  ];

  networking = {
    hostName = "remote";
    extraHosts = ''
      128.140.88.66 h
    '';
  };
}
