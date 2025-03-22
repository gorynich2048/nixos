{ lib, ... }: {
  imports = [
    ../../modules/shared
    ../../modules/dev

    ./hardware-configuration.nix
    ./programs.nix
    ./services.nix
    ./nvidia.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "local";
    extraHosts = ''
      130.61.52.25 xcore1
      176.9.86.158 host
    '';
    nat = {
      enable = true;
      internalIPs = [ "192.168.100.0/24" ];
      externalInterface = "enp4s0";
    };
  };

  systemd.network = {
    enable = true;
    networks = let
      maxVMs = 16;
    in builtins.listToAttrs (
        map (index: {
          name = "10-vm${toString index}";
          value = {
            matchConfig.Name = "vm${toString index}";
            # Host's addresses
            address = [
              "192.168.100.0/32"
              "fec0::/128"
            ];
            # Setup routes to the VM
            routes = [
              { Destination = "192.168.100.${toString index}/32"; }
              { Destination = "fec0::${lib.toHexString index}/128"; }
            ];
            # Enable routing
            networkConfig = {
              IPv4Forwarding = true;
              IPv6Forwarding = true;
            };
          };
        }) (lib.genList (i: i + 1) maxVMs)
      );
  };

  security.rtkit.enable = true;

  system.stateVersion = "23.11"; # NEVER CHANGE
  home-manager = {
    users.user.home.stateVersion = "23.11"; # NEVER CHANGE
    users.root.home.stateVersion = "23.11"; # NEVER CHANGE
    backupFileExtension = "backup";
  };
}
