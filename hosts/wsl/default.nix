{ nixos-wsl, ... }: {
  imports = [
    nixos-wsl.nixosModules.default
    ../../modules/base.nix
    ../../modules/sshd.nix
    ../../modules/fish.nix
    ../../modules/direnv.nix
    ../../modules/programs.nix
    ../../modules/nixvim
    ../../modules/nixvim_remote.nix

    ./programs.nix
    ./ssh_vpn.nix
  ];

  wsl = {
    enable = true;
    defaultUser = "user";
  };

  networking = {
    hostName = "wsl";
  };

  users.users.user = {
    uid = 1000;
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIANY37jZd9CA4E2ktVrexTOochSow1yE4NYfCUB74fDC gorynich"
    ];
  };

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIANY37jZd9CA4E2ktVrexTOochSow1yE4NYfCUB74fDC gorynich"
  ];

  system.stateVersion = "23.11"; # NEVER CHANGE
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
}
