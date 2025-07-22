{ pkgs, ... }: {
  environment = {
    systemPackages = with pkgs; [
      killall
      ripgrep
      fd
      aria
      unzip
      speedtest-cli
      neofetch
    ];
  };
}
