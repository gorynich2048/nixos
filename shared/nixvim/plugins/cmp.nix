{
  programs.nixvim = {
    plugins = {
      cmp = {
        enable = true;

        settings = {
          mapping = {
            "<C-u>" = "cmp.mapping.scroll_docs(-4)";
            "<C-d>" = "cmp.mapping.scroll_docs(4)";
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            "<Down>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            "<Up>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
          };

          sources = [
            {name = "path";}
            {name = "nvim_lsp";}
            # {
            #   name = "buffer";
            #   # Words from other open buffers can also be suggested.
            #   option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
            # }
          ];
        };
      };
    };
  };
}
