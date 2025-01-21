{ pkgs, ... }: {
  environment = {
    systemPackages = with pkgs; [
      git
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
        alias cmd='/mnt/c/Windows/System32/cmd.exe /c'
        alias pwsh='/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe /c'
      '';
    };
  };

  home-manager.users.user = {
    programs = {
      fish.enable = true;
    };
  };
}
