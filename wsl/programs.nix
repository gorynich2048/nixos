{ pkgs, ... }: {
  environment = {
    systemPackages = with pkgs; [
      p4
      tmux
    ];
  };
}
