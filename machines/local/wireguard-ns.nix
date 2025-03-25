{ pkgs, ... }: {
  systemd.services = {
    wg-ns = {
      requiredBy = [ "network-pre.target" ];
      serviceConfig = let
        ip = "${pkgs.iproute2}/bin/ip";
      in {
        Type = "oneshot";
        RemainAfterExit = "yes";
        ExecStart = pkgs.writers.writeBash "wg-ns-up" ''
          ${ip} netns add wg
          ${ip} link add link enp4s0 name en0 netns wg type macvlan
          ${ip} -n wg link set en0 up
          ${ip} -n wg addr add 192.168.1.200/24 dev en0
          ${ip} -n wg route add 176.9.86.158 via 192.168.1.1
        '';
        ExecStop = pkgs.writers.writeBash "wg-ns-down" ''
          ${ip} netns del wg
        '';
      };
    };
  };
}
