{
  programs.nixvim = {
    autoCmd = [
      # Enable line numbers in terminal
      {
        event = "TermOpen";
        command = "setlocal number relativenumber";
      }

      # Update global marks
      {
        event = "BufLeave";
        callback.__raw = ''
          function(args)
            if vim.b[args.buf].disable_global_marks then return end

            local cur = vim.fn.expand('%:p')
            for _, m in ipairs(vim.fn.getmarklist()) do
              if m.mark:sub(2):match('^[A-Z]$') and vim.fn.fnamemodify(m.file, ':p') == cur then
                vim.cmd('normal! m' .. m.mark:sub(2))
              end
            end
          end
        '';
      }

      # Run rustfmt on save
      {
        event = "BufWritePre";
        pattern = [ "*.rs" ];
        callback.__raw = "function() vim.lsp.buf.format({ async = false }) end";
      }

      # Load bevy vscode snippets
      {
        event = "DirChanged";
        pattern = [ "*" ];
        callback.__raw = ''
          function()
            require("luasnip.loaders.from_vscode").load_standalone({ path = ".vscode/bevy.code-snippets" })
          end
        '';
      }

      # Disable comments continuation
      {
        event = "FileType";
        pattern = [ "*" ];
        command = "setlocal formatoptions-=ro";
      }
    ];
  };
}
