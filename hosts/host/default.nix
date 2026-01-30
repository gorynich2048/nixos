{ ... }: {
  imports = [
    ../../modules/base.nix
    ../../modules/dns_stubby.nix
    ../../modules/sshd.nix
    ../../modules/fish.nix
    ../../modules/direnv.nix
    ../../modules/programs.nix

    ./disk-config.nix
    ./hardware-configuration.nix
    ./vm_services.nix
    ./vm_network.nix
  ];

  boot.loader.grub = {
    efiSupport = true;
    efiInstallAsRemovable = true;
    configurationLimit = 10;
  };

  networking = {
    hostName = "host";
    useDHCP = false;
  };

  systemd.network = {
    enable = true;
    networks."0-en" = {
      matchConfig.Name = "en*";
      DHCP = "no";
      address = [ "138.201.221.18/26" ];
      routes = [
        {
          Gateway = "138.201.221.1";
          GatewayOnLink = true;
        }
      ];
      linkConfig.RequiredForOnline = "routable";
    };
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
