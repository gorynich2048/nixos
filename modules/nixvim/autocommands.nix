{
  programs.nixvim = {
    autoCmd = [
      # Toggle terminal mode line numbers
      # {
      #   event = "TermEnter";
      #   command = "setlocal nonumber norelativenumber";
      # }
      # {
      #   event = "TermLeave";
      #   command = "setlocal number relativenumber";
      # }

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
    ];
  };
}
