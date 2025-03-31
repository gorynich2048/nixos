{ lib, pkgs, ... }:
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
    systemd-boot = {
      enable = true;
      configurationLimit = 10;
    };
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

  users.users.user = {
    uid = 1000;
    shell = pkgs.fish;
    isNormalUser = true;
    linger = true;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFPe92LGBClSeLpArZLDjFGzg5LK8G6pA3TQ4RaNszRa root@wsl"
    ];
  };

  virtualisation.vmVariantWithBootLoader.virtualisation = {
    graphics = false;
    qemu = {
      networkingOptions = lib.mkForce [
        "-nic tap,script=no,downscript=no,vhost=on,model=virtio-net-pci,ifname=vm${toString index},mac=${mac}"
      ];
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
    backupFileExtension = "backup";
  };
}
