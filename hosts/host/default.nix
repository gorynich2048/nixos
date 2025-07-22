{ ... }: {
  imports = [
    ../../modules/base.nix
    ../../modules/sshd.nix
    ../../modules/fish.nix
    ../../modules/direnv.nix
    ../../modules/programs.nix
    ../../modules/kvm.nix

    ./disk-config.nix
    ./hardware-configuration.nix
    ./services.nix
    ./network.nix
    ./ssh_lab.nix
  ];

  boot.loader.grub = {
    efiSupport = true;
    efiInstallAsRemovable = true;
    configurationLimit = 10;
  };

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIANY37jZd9CA4E2ktVrexTOochSow1yE4NYfCUB74fDC gorynich"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAr87Ijv/4gAllpnZrhaQZhW+iI/HzAMEjaxFsbrA91L continue"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIke/35rx1Hemk61WLo9CtGkrsKfVsgcerFgXZpmpkdf ragamaffin"
  ];

  system.stateVersion = "24.05"; # NEVER CHANGE
  home-manager = {
    users.root = {
      imports = [
        ../../modules/btop_home.nix
      ];
      home.stateVersion = "24.05"; # NEVER CHANGE
    };
    backupFileExtension = "backup";
  };
}
