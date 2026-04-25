{
  imports = [
    ../../modules/base.nix
    ../../modules/systemd_dhcp.nix
    ../../modules/fish.nix
    ../../modules/nixvim
    ../../modules/nixvim_local.nix
    ../../modules/direnv.nix
    ../../modules/programs.nix
    ../../modules/cross_aarch64.nix

    ./disk-config.nix
    ./hardware-configuration.nix
    ./wayland.nix
    ./programs.nix
    ./pipewire.nix
    ./nvidia.nix
    ./qutebrowser.nix
    ./wireguard.nix
  ];

  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 10;
    };
    efi.canTouchEfiVariables = true;
  };

  # Configure mouse: https://www.xvalleyinno.top/AttackShark/#/project/items
  services.udev.extraRules = ''
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="373e", ATTRS{idProduct}=="0047", MODE="0666", TAG+="uaccess"
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="373e", ATTRS{idProduct}=="0046", MODE="0666", TAG+="uaccess"
  '';

  networking = {
    hostName = "local";
    extraHosts = ''
      138.201.221.18 host
    '';
  };
  networking = {
    nameservers = [ "10.2.0.1" ];
    dhcpcd.extraConfig = "nohook resolv.conf";
  };
  services.resolved.enable = false;

  users.users.user = {
    uid = 1000;
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIANY37jZd9CA4E2ktVrexTOochSow1yE4NYfCUB74fDC gorynich"
    ];
  };

  home-manager = {
    users.user = {
      imports = [
        ../../modules/btop_home.nix
        ../../modules/git_home.nix
        ../../modules/zathura_home.nix
      ];
      home.stateVersion = "23.11"; # NEVER CHANGE
    };
    users.root.home.stateVersion = "23.11"; # NEVER CHANGE
    backupFileExtension = "backup";
  };
  system.stateVersion = "23.11"; # NEVER CHANGE
}
