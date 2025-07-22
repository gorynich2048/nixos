{ ... }: {
  security.rtkit.enable = true;
  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;

      extraConfig.pipewire-pulse."10-lock-mic-volume" = {
        "pulse.rules" = [
          {
            matches = [
              { "application.id" = "!org.PulseAudio.pavucontrol"; }
            ];
            actions = {
              quirks = [ "block-source-volume" ];
            };
          }
        ];
      };
    };
  };
}
