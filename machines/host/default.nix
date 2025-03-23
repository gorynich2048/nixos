{ disko, ... }: {
  imports = [
    ../../modules/shared
    ../../modules/remote
    ../../modules/kvm

    disko.nixosModules.disko
    ./disk-config.nix
    ./hardware-configuration.nix
    ./services.nix
  ];

  boot.loader.grub = {
    device = "/dev/nvme0n1";
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  networking = {
    hostName = "host";
    interfaces = {
      eth0 = {
        ipv4.addresses = [{
          address = "176.9.86.158";
          prefixLength = 27;
        }];
        ipv6.addresses = [{
          address = "2a01:4f8:151:2484::2";
          prefixLength = 64;
        }];
      };
    };
    defaultGateway = {
      address = "176.9.86.129";
      interface = "eth0";
    };
    defaultGateway6 = {
      address = "fe80::1";
      interface = "eth0";
    };
  };

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAr87Ijv/4gAllpnZrhaQZhW+iI/HzAMEjaxFsbrA91L continue"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIke/35rx1Hemk61WLo9CtGkrsKfVsgcerFgXZpmpkdf ragamaffin"
  ];

  system.stateVersion = "24.05"; # NEVER CHANGE
  home-manager = {
    users.root.home.stateVersion = "24.05"; # NEVER CHANGE
    backupFileExtension = "backup";
  };
}
