{
  imports = [
    ../../modules/base.nix
    ../../modules/systemd_dhcp.nix
    ../../modules/dns.nix
    ../../modules/fish.nix
    ../../modules/nixvim
    ../../modules/direnv.nix
    ../../modules/programs.nix

    ./hardware-configuration.nix
    ./programs.nix
    ./pipewire.nix
    ./nvidia.nix
    ./zapret.nix
  ];

  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 10;
    };
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "local";
    extraHosts = ''
      138.201.221.18 host
    '';
  };

  users.users.user = {
    uid = 1000;
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIANY37jZd9CA4E2ktVrexTOochSow1yE4NYfCUB74fDC gorynich"
    ];
  };

  home-manager = {
    users.user = {
      imports = [
        ../../modules/btop_home.nix
        ../../modules/git_home.nix
      ];
      home.stateVersion = "23.11"; # NEVER CHANGE
    };
    users.root.home.stateVersion = "23.11"; # NEVER CHANGE
    backupFileExtension = "backup";
  };
  system.stateVersion = "23.11"; # NEVER CHANGE
}
