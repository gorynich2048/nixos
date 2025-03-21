{ pkgs, ... }: {
  environment = {
    systemPackages = with pkgs; [
      git
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
        alias cmd='/mnt/c/Windows/System32/cmd.exe /c'
        alias pwsh='/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe /c'
      '';
    };
  };

  home-manager.users.root = {
    imports = [
      ../../home_modules/btop.nix
    ];

    programs = {
      fish.enable = true;
    };
  };
}
