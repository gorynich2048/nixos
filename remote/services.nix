{ ... }: {
  services = {
    openssh = {
      enable = true;
      ports = [ 40022 ];
      settings = {
        PasswordAuthentication = false;
      };
    };
  };
}
