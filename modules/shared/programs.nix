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

  programs = {
    fish = {
      enable = true;
      # TODO: remove aliases from global config
      interactiveShellInit = ''
        set fish_greeting ""
        alias vi=$EDITOR
        alias grep=rg
        alias wget=aria2c
        alias cmd='/mnt/c/Windows/System32/cmd.exe /c'
        alias pwsh='/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe /c'
      '';
    };
  };

  users.users.root = {
    shell = pkgs.fish;
  };

  home-manager.users.root = {
    imports = [
      ../../home_modules/btop.nix
      ../../home_modules/git.nix
    ];

    programs = {
      fish.enable = true;
    };
  };
}
