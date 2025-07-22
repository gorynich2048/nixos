{ pkgs, ... }: {
  programs = {
    fish = {
      enable = true;
      # TODO: remove aliases from global config
      interactiveShellInit = ''
        set fish_greeting ""
        bind shift-right nextd-or-forward-word
        alias vi=$EDITOR
        alias grep=rg
        alias wget=aria2c
        alias cmd='/mnt/c/Windows/System32/cmd.exe /c'
        alias pwsh='/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe /c'
      '';
    };
  };

  users.defaultUserShell = pkgs.fish;
}
