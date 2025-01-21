{ pkgs, ... }: {
  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  systemd = {
    user.services = {
      alsa-restore = {
         wantedBy = [ "default.target" ];
         wants = [ "pipewire.service" ];
         serviceConfig = {
           ExecStartPre = "${pkgs.coreutils-full}/bin/sleep 5";
           ExecStart = "${pkgs.alsa-utils}/bin/alsactl restore -L";
         };
      };
    };
  };
}
