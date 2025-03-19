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
    direnv = {
      enable = true;
      silent = true;
      nix-direnv.enable = true;
    };
  };

  home-manager.users.user = {
    programs = {
      fish.enable = true;
      btop = {
        enable = true;
        settings = {
          rounded_corners = false;
          theme_background = false;
          show_gpu_info = "On";
          show_coretemp = false;
          cpu_graph_lower = "system";
          update_ms = 100;
        };
      };
    };
  };
}
