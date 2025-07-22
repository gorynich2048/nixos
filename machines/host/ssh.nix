{
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAr87Ijv/4gAllpnZrhaQZhW+iI/HzAMEjaxFsbrA91L continue"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIke/35rx1Hemk61WLo9CtGkrsKfVsgcerFgXZpmpkdf ragamaffin"
  ];

  home-manager = {
    users.root = {
      programs.ssh = {
        enable = true;
        matchBlocks = {
          vpn = {
            hostname = "192.168.100.1";
            port = 22;
            user = "root";
            identityFile = "/etc/ssh/ssh_host_ed25519_key";
          };
        };
      };
    };
  };
}
