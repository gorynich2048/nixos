{ pkgs, ... }: {
  environment = {
    systemPackages = with pkgs; [
      p4
      tmux
    ];
  };

  home-manager.users.user = {
    imports = [
      ../shared/btop.nix
    ];
  };
}
