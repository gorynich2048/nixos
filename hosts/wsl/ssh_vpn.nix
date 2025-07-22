{
  home-manager = {
    users.root = {
      programs.ssh = {
        enable = true;
        matchBlocks = {
          lab = {
            hostname = "138.201.221.18";
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
