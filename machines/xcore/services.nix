{ lib, pkgs, ... }: {
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "mongodb"
    ];

  services.mongodb = {
    enable = true;
  };

  systemd.user.services = {
    tmux-xcore = {
      wantedBy = [ "default.target" ];
      restartIfChanged = false;
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = "yes";
        ExecStart = pkgs.writers.writeBash "tmux-start" ''
          PATH=$PATH:/run/current-system/sw/bin
          ~/start.sh
        '';
        ExecStop = pkgs.writers.writeBash "tmux-stop" ''
          PATH=$PATH:/run/current-system/sw/bin
          ~/stop.sh
        '';
      };
    };
  };
}
