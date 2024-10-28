{ config, lib, pkgs, nixpkgs, home-manager, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./modules
    ./programs.nix
    ./services.nix
    (import "${home-manager}/nixos")
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.nixPath = [ "nixpkgs=${nixpkgs}" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # boot.kernelPackages = pkgs.linuxPackages_latest;
  networking = {
    hostName = "local";
    extraHosts = ''
      130.61.52.25 xcore1
      128.140.88.66 h
      172.30.0.1 parascript
    '';
  };

  # xdg.portal = {
  #   enable = true;
  #   # gtk portal needed to make gtk apps happy
  #   extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
  # };

  # networking.firewall.allowedTCPPorts = [ 80 ];

  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "C.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };
  # i18n.extraLocaleSettings = { LC_TIME = "ru_RU.UTF-8"; };

  # Enable sound.
  # sound.enable = true;
  # boot.blacklistedKernelModules = [ "snd_pcsp" ];
  # hardware.pulseaudio.enable = true;
  # Remove sound.enable or set it to false if you had it set previously, as sound.enable is only meant for ALSA-based configurations

  # rtkit is optional but recommended
  security.rtkit.enable = true;
  users.users.user = {
    uid = 1000;
    shell = pkgs.fish;
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  # networking = {
  #   # Enable WireGuard
  #   wireguard.interfaces = {
  #     # "wg0" is the network interface name. You can name the interface arbitrarily.
  #     wg0 = {
  #       # Determines the IP address and subnet of the client's end of the tunnel interface.
  #       ips = [ "192.168.89.11/24" ];

  #       # Path to the private key file.
  #       #
  #       # Note: The private key can also be included inline via the privateKey option,
  #       # but this makes the private key world-readable; thus, using privateKeyFile is
  #       # recommended.
  #       privateKeyFile = "/home/user/.ssh/wg-key";
  #       allowedIPsAsRoutes = false;

  #       peers = [
  #         # For a client configuration, one peer entry for the server will suffice.

  #         {
  #           # Public key of the server (not a file path).
  #           publicKey = "4Iy7uSq5j3X1IdrzlJ/QqGWtyRPUOgQNBMoh3K2xGVs=";
  #           presharedKeyFile = "/home/user/.ssh/wg-key-preshared";

  #           # Forward all the traffic via VPN.
  #           allowedIPs = [ "0.0.0.0/0" ];
  #           # Or forward only particular subnets
  #           #allowedIPs = [ "10.100.0.1" "91.108.12.0/22" ];

  #           # Set this to the server IP and port.
  #           endpoint =
  #             "new.vpn.continuedev.ru:44121"; # ToDo: route to endpoint not automatically configured https://wiki.archlinux.org/index.php/WireGuard#Loop_routing https://discourse.nixos.org/t/solved-minimal-firewall-setup-for-wireguard-client/7577

  #           # Send keepalives every 25 seconds. Important to keep NAT tables alive.
  #           persistentKeepalive = 25;
  #         }
  #       ];
  #     };
  #   };
  # };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  system.stateVersion = "23.11"; # NEVER CHANGE
  home-manager.users.user = {
    home.stateVersion = "23.11"; # NEVER CHANGE
  };
}
