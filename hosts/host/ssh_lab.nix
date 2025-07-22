{
  home-manager = {
    users.root = {
      programs.ssh = {
        enable = true;
        matchBlocks = {
          lab = {
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
