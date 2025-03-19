{ pkgs, nixpkgs, home-manager, ... }: {
  imports = [
    ./programs.nix
    ./nixvim
    (import "${home-manager}/nixos")
  ];

  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
    nixPath = [ "nixpkgs=${nixpkgs}" ];
    daemonCPUSchedPolicy = "idle";
    daemonIOSchedClass = "idle";
    gc.automatic = true;
  };

  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "C.UTF-8";

  users.users = {
    user = {
      uid = 1000;
      shell = pkgs.fish;
      isNormalUser = true;
      extraGroups = [ "wheel" ];
    };
    root.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIANY37jZd9CA4E2ktVrexTOochSow1yE4NYfCUB74fDC gorynich"
    ];
  };

  system.stateVersion = "23.11"; # NEVER CHANGE
  home-manager = {
    users.user = {
      home.stateVersion = "23.11"; # NEVER CHANGE
    };
    backupFileExtension = "backup";
  };
}
