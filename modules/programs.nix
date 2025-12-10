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
      unrar

      # fancy stuff
      speedtest-cli
      neofetch
    ];
  };
}
