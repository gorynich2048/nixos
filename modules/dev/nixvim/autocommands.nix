{
  programs.nixvim = {
    autoCmd = [
      # Enable spellcheck for some filetypes
      {
        event = "FileType";
        pattern = [
          "tex"
          "latex"
          "markdown"
        ];
        command = "setlocal spell spelllang=en";
      }
      # Enable line numbers in terminal
      {
        event = "TermOpen";
        command = "setlocal number relativenumber";
      }
    ];
  };
}
