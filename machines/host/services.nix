{ ... }: {
  services = {
    ocserv = {
      enable = true;
      config = builtins.readFile ./ocserv.conf;
    };
  };
}
