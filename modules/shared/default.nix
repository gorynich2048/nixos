{ nixpkgs, home-manager, ... }: {
  imports = [
    ./programs.nix
    (import "${home-manager}/nixos")
  ];

  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
    nixPath = [ "nixpkgs=${nixpkgs}" ];
    daemonCPUSchedPolicy = "idle";
    daemonIOSchedClass = "idle";
    gc.automatic = true;
  };

  networking.nameservers = [ "1.1.1.1" "8.8.8.8" ];

  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "C.UTF-8";
}
