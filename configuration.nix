{ pkgs, nixpkgs, home-manager, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./modules
    ./programs.nix
    ./services.nix
    (import "${home-manager}/nixos")
  ];

  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
    nixPath = [ "nixpkgs=${nixpkgs}" ];
    daemonCPUSchedPolicy = "idle";
    daemonIOSchedClass = "idle";
    gc.automatic = true;
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
  networking = {
    hostName = "local";
    extraHosts = ''
      130.61.52.25 xcore1
      128.140.88.66 h
    '';
  };

  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "C.UTF-8";

  security.rtkit.enable = true;
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
