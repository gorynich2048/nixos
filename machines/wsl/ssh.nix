{
  home-manager = {
    users.root = {
      programs.ssh = {
        enable = true;
        matchBlocks = {
          vpn = {
            hostname = "176.9.86.158";
            port = 51000;
            user = "user";
            identityFile = "/etc/ssh/ssh_host_ed25519_key";
            remoteForwards = [{
              bind.address = "*";
              bind.port = 51001;
              host.address = "localhost";
              host.port = 22;
            }];
          };
        };
      };
    };
  };
}
