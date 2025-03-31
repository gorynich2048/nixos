{
  programs.tmux = {
    enable = true;
    clock24 = true;
    keyMode = "vi";
    extraConfig = ''
      set -g prefix2 C-a
      set -g status-style 'bg=default,fg=white'
      set -g window-status-current-style 'bg=blue,fg=black'
      set -s escape-time 10  # faster command sequences
    '';
  };
}
