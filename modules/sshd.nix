{
  services = {
    openssh = {
      enable = true;
      authorizedKeysInHomedir = false;
      settings = {
        PasswordAuthentication = false;
        PermitTunnel = "yes";
        ClientAliveInterval = 60;
        ClientAliveCountMax = 3;
      };
    };
  };
}
