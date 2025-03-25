{ pkgs, ... }: {
  systemd.services = {
    wg-ns = {
      requiredBy = [ "network-pre.target" ];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = "yes";
      };
      script = (let
        ip = "${pkgs.iproute2}/bin/ip";
      in ''
        ${ip} netns add wg
        ${ip} link add link enp4s0 name en0 netns wg type macvlan
        ${ip} netns exec wg ${ip} link set en0 up
        ${ip} netns exec wg ${ip} addr add 192.168.1.200/24 dev en0
        ${ip} netns exec wg ${ip} route add 176.9.86.158 via 192.168.1.1
      '');
    };
  };
}
