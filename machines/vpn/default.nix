{ lib, ... }:
let
  index = 1;
  mac = "00:00:00:00:00:01";
in {
  imports = [
    ../../modules/shared
    ../../modules/remote
    ../../modules/wireguard/server.nix

    ./hardware-configuration.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "vpn";
    useDHCP = false;
  };

  systemd.network = {
    enable = true;
    networks."10-eth" = {
      matchConfig.MACAddress = mac;
      address = [
        "192.168.100.${toString index}/32"
        "fec0::${lib.toHexString index}/128"
      ];
      routes = [
        {
          Destination = "192.168.100.0/32";
          GatewayOnLink = true;
        }
        {
          Destination = "0.0.0.0/0";
          Gateway = "192.168.100.0";
          GatewayOnLink = true;
        }
        {
          Destination = "::/0";
          Gateway = "fec0::";
          GatewayOnLink = true;
        }
      ];
    };
  };

  virtualisation.vmVariantWithBootLoader.virtualisation = {
    graphics = false;
    qemu.networkingOptions = lib.mkForce [
      "-netdev tap,id=nd0,ifname=vm${toString index},script=no,downscript=no"
      "-device virtio-net-pci,netdev=nd0,mac=${mac}"
    ];
    cores = 4;
    memorySize = 16384;
    # TODO: does not work
    # diskSize = 65536;
  };

  system.stateVersion = "24.05"; # NEVER CHANGE
  home-manager = {
    users.root.home.stateVersion = "24.05"; # NEVER CHANGE
    backupFileExtension = "backup";
  };
}
