{
  services = {
    openssh = {
      enable = true;
      authorizedKeysInHomedir = false;
      settings = {
        PasswordAuthentication = false;
        PermitTunnel = "yes";
      };
    };
  };
}
