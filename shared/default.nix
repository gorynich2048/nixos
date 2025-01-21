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

  users.users.user = {
    uid = 1000;
    shell = pkgs.fish;
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  system.stateVersion = "23.11"; # NEVER CHANGE
  home-manager = {
    users.user = {
      home.stateVersion = "23.11"; # NEVER CHANGE
    };
    backupFileExtension = "backup";
  };
}
