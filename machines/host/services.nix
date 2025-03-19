{ ... }: {
  services = {
    ocserv = {
      enable = true;
      config = ''       
        auth = "plain[passwd=/home/user/ocpasswd]"
      '';
    };
  };
}
