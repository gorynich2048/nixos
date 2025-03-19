{ ... }: {
  services = {
    openssh = {
      enable = true;
      ports = [ 1022 ];
      settings = {
        PasswordAuthentication = false;
      };
    };
  };
}
