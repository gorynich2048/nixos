{ ... }: {
  imports = [
    ../../modules/shared
    ../../modules/remote
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "vpn";
  };

  virtualisation.vmVariant = {
    virtualisation = {
      graphics = false;
    };
  };

  system.stateVersion = "24.05"; # NEVER CHANGE
  home-manager = {
    users.root.home.stateVersion = "24.05"; # NEVER CHANGE
    backupFileExtension = "backup";
  };
}
