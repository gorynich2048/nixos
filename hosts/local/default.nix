{
  imports = [
    ../../modules/base.nix
    ../../modules/systemd_dhcp.nix
    ../../modules/dns.nix
    ../../modules/fish.nix
    ../../modules/nixvim
    ../../modules/nixvim_local.nix
    ../../modules/direnv.nix
    ../../modules/programs.nix
    ../../modules/cross_aarch64.nix

    ./disk-config.nix
    ./hardware-configuration.nix
    ./wayland.nix
    ./programs.nix
    ./pipewire.nix
    ./nvidia.nix
    ./qutebrowser.nix
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
