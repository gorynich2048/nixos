{ nixos-wsl, ... }: {
  imports = [
    nixos-wsl.nixosModules.default
    ../../modules/shared
    ../../modules/dev
    ../../modules/remote
    ../../modules/remote_dev

    ./programs.nix
    ./ssh.nix
  ];

  wsl = {
    enable = true;
    defaultUser = "user";
  };

  networking = {
    hostName = "wsl";
  };

  system.stateVersion = "23.11"; # NEVER CHANGE
  home-manager = {
    users.user.home.stateVersion = "23.11"; # NEVER CHANGE
    users.root.home.stateVersion = "23.11"; # NEVER CHANGE
    backupFileExtension = "backup";
  };
}
