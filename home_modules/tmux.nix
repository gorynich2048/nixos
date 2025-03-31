{
  programs.tmux = {
    enable = true;
    clock24 = true;
    extraConfig = ''
      set -g prefix2 C-a
      set -g status-style 'bg=#1f1f1f,fg=#dfdfdf'
      set -g window-status-current-style 'bg=#007fff,fg=#dfdfdf'
    '';
  };
}
