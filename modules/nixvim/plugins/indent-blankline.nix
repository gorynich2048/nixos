{
  programs.nixvim = {
    highlight.CurrentScope.fg = "#61afef";

    plugins.indent-blankline = {
      enable = true;
      settings = {
        scope = {
          show_start = false;
          show_end = false;
          highlight = "CurrentScope";
        };
      };
    };
  };
}
