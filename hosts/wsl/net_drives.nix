{ pkgs, ... }: {
  systemd.services = {
    net-drives = {
      wantedBy = [ "multi-user.target" ];
      requires = [ "network-online.target" ];
      path = with pkgs; [ mount ];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = "yes";
      };
      script = ''
        NET_DR="/mnt/L"
        mkdir -p "$NET_DR"
        mount -t drvfs '\\laniwot1\PSTest' "$NET_DR"
        # NET_DR="/mnt/N"
        # mkdir -p "$NET_DR"
        # mount -t drvfs '\\laniwot6\PSTestgray' "$NET_DR"
        # NET_DR="/mnt/P"
        # mkdir -p "$NET_DR"
        # mount -t drvfs '\\laniwot2\New_Ver' "$NET_DR"
        # NET_DR="/mnt/V"
        # mkdir -p "$NET_DR"
        # mount -t drvfs '\\laniwot2\PSDataBase' "$NET_DR"
        # NET_DR="/mnt/X"
        # mkdir -p "$NET_DR"
        # mount -t drvfs '\\dtest\share' "$NET_DR"
      '';
    };
  };
}
