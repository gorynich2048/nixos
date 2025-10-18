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
      # Update global marks
      {
        event = "BufLeave";
        command = ''
          function! s:in_current_file(marks)
            return a:marks->filter({_, mark_info -> fnamemodify(mark_info.file, ':p') == expand('%:p')})
          endfunction

          function! s:global_alpha_marks()
            return getmarklist()->filter({_, mark_info -> mark_info.mark[1:] =~? '[[:alpha:]]'})
          endfunction

          for info in s:global_alpha_marks()->s:in_current_file()
            exe 'normal! m' . info.mark[1:]
          endfor
        '';
      }
      # Run rustfmt on save
      {
        event = "BufWritePre";
        pattern = [ "*.rs" ];
        command = "lua vim.lsp.buf.format()";
      }
    ];
  };
}
