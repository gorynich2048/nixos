{ pkgs, ... }: {
  systemd.services = {
    reverse-ssh = {
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = ''
          ${pkgs.openssh}/bin/ssh \
            -R "*:51001:localhost:22" \
            user@128.140.88.66 -p 51000 \
            -i /etc/ssh/ssh_host_ed25519_key
        '';
      };
    };
  };
}
