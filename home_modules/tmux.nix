{
  programs.tmux = {
    enable = true;
    clock24 = true;
    keyMode = "vi";
    extraConfig = ''
      set -g prefix2 C-a
      set -g default-terminal "screen-256color"
      set -g status-style 'bg=default,fg=#dfdfdf'
      set -g window-status-current-style 'bg=#007fff,fg=#dfdfdf'
      set -s escape-time 10  # faster command sequences
    '';
  };
}
