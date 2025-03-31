{ lib, ... }: {
  imports = [
    ../../modules/shared
    ../../modules/remote
    ../../modules/wireguard/server.nix

    ./hardware-configuration.nix
    ./network.nix
    ./ssh.nix
  ];

  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 10;
    };
    efi.canTouchEfiVariables = true;
  };

  virtualisation.vmVariantWithBootLoader.virtualisation = {
    graphics = false;
    qemu = {
      options = [
        "-device virtio-balloon,free-page-reporting=on"
      ];
      virtioKeyboard = false;
    };
    cores = 12;
    memorySize = 20480;
    sharedDirectories = lib.mkForce {};
    # TODO: does not work
    # diskSize = 65536;
  };

  system.stateVersion = "24.05"; # NEVER CHANGE
  home-manager = {
    users.root.home.stateVersion = "24.05"; # NEVER CHANGE
    users.user.home.stateVersion = "24.05"; # NEVER CHANGE
    backupFileExtension = "backup";
  };
}
