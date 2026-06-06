{ pkgs, ... }: {
  environment = {
    systemPackages = with pkgs; [
      # system utils
      killall
      ripgrep
      fd
      aria2
      dig
      traceroute
      unar
      xxd
      tcpdump

      # fancy stuff
      speedtest-cli
      hyfetch
    ];
  };
}
