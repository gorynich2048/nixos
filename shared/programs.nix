{ pkgs, ... }: {
  environment = {
    systemPackages = with pkgs; [
      git
      btop
      killall
      ripgrep
      fd
      aria
      unzip
    ];
  };

  programs = {
    fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting ""
        alias vi=$EDITOR
        alias grep=rg
      '';
    };
  };

  home-manager.users.user = {
    programs = {
      fish.enable = true;
    };
  };
}
