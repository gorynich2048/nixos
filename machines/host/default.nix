{ ... }: {
  imports = [
    ../../modules/shared
    ../../modules/remote
    ../../modules/kvm

    ./disk-config.nix
    ./hardware-configuration.nix
    ./services.nix
    ./network.nix
    ./ssh.nix
  ];

  boot.loader.grub = {
    efiSupport = true;
    efiInstallAsRemovable = true;
    configurationLimit = 10;
  };

  system.stateVersion = "24.05"; # NEVER CHANGE
  home-manager = {
    users.root.home.stateVersion = "24.05"; # NEVER CHANGE
    backupFileExtension = "backup";
  };
}
