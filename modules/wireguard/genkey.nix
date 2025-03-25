{ pkgs, ... }: {
  systemd.services = {
    gen-wg-key = {
      requiredBy = [ "network-pre.target" ];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = "yes";
      };
      script = ''
        if [ ! -f /var/wg/private ]; then
          umask 077
          mkdir -p /var/wg
          ${pkgs.wireguard-tools}/bin/wg genkey > /var/wg/private
          ${pkgs.wireguard-tools}/bin/wg pubkey < /var/wg/private > /var/wg/public
          chown -R systemd-network /var/wg
        fi
      '';
    };
  };

  networking.wireguard.interfaces.wg0.privateKeyFile = "/var/wg/private";
}
