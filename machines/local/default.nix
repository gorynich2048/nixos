{ ... }: {
  imports = [
    ./hardware-configuration.nix
    ./programs.nix
    ./services.nix
    ./nvidia.nix
    ../../shared
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "local";
    extraHosts = ''
      130.61.52.25 xcore1
      128.140.88.66 h
    '';
  };

  security.rtkit.enable = true;
}
