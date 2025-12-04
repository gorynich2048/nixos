{ pkgs, ... }: {
  environment = {
    systemPackages = with pkgs; [
      killall
      ripgrep
      fd
      aria2
      unzip
      speedtest-cli
      neofetch
    ];
  };
}
