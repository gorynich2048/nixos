{ ... }: {
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

  virtualisation.libvirtd.enable = true;

  networking = {
    hostName = "local";
    extraHosts = ''
      130.61.52.25 xcore1
      176.9.86.158 host
    '';
  };

  security.rtkit.enable = true;

  system.stateVersion = "23.11"; # NEVER CHANGE
  home-manager = {
    users.user = {
      home.stateVersion = "23.11"; # NEVER CHANGE
    };
    users.root = {
      home.stateVersion = "23.11"; # NEVER CHANGE
    };
    backupFileExtension = "backup";
  };
}
