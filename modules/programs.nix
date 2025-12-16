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
      unzip

      # fancy stuff
      speedtest-cli
      neofetch
    ];
  };
}
