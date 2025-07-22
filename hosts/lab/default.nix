{ lib, ... }: {
  imports = [
    ../../modules/base.nix
    ../../modules/sshd.nix
    ../../modules/fish.nix
    ../../modules/direnv.nix
    ../../modules/programs.nix
    ../../modules/wireguard
    ../../modules/wireguard_server.nix

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

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIANY37jZd9CA4E2ktVrexTOochSow1yE4NYfCUB74fDC gorynich"
  ];

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
