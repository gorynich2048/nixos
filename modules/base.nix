{ nixpkgs, home-manager, ... }: {
  imports = [
    (import "${home-manager}/nixos")
  ];

  users.users.root.initialHashedPassword = "";

  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
    nixPath = [ "nixpkgs=${nixpkgs}" ];
    daemonCPUSchedPolicy = "idle";
    daemonIOSchedClass = "idle";
    gc.automatic = true;
    gc.dates = "weekly";
    optimise.automatic = true;
    optimise.dates = [ "weekly" ];
  };

  networking.nameservers = [ "1.1.1.1" "8.8.8.8" ];

  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "C.UTF-8";
}
