{ lib, config, ... }: {
  programs.nixvim = {
    globals = {
      loaded_ruby_provider = 0;
      loaded_perl_provider = 0;
      loaded_python3_provider = 0;
      loaded_node_provider = 0;
      terminal_scrollback_buffer_size = 100000;
    };

    clipboard = {
      register = lib.mkIf (config.networking.hostName == "local") "unnamedplus";
      providers.wl-copy.enable = true;
    };

    opts = {
      updatetime = 100; # Faster completion

      relativenumber = true;
      number = true;
      mouse = "a";
      mousemodel = "popup_setpos";
      splitbelow = true;
      splitright = true;

      swapfile = false;
      ignorecase = true;
      smartcase = true;
      scrolloff = 8;
      signcolumn = "yes";
      laststatus = 3;
      wrap = false;

      # Tab options
      tabstop = 4;
      shiftwidth = 4;
      expandtab = true;

      # Folding
      foldmethod = "expr";
      foldlevel = 99;

      virtualedit = "block";
      shadafile = "NONE";
      jumpoptions = ["stack" "clean"];
    };

    colorschemes.onedark = {
      enable = true;
      settings = {
        transparent = true;
        ending_tildes = true;
        code_style = {
          comments = "none";
        };
        highlights = {
          Search.bg = "#abb2bf";
          IncSearch.bg = "#e86671";
          CurSearch.bg = "#e86671";
          CurrentScope.fg = "#61afef";
          TelescopeMatching.fg = "#e86671";
          BlinkCmpLabelMatch.fg = "#e86671";

          "@spell".fg = "NONE";
          "@nospell".fg = "NONE";

          "@variable.parameter".fg = "#abb2bf";
          "@variable.member".fg = "#abb2bf";
          "@variable.builtin".fg = "#abb2bf";
          "@property".fg = "#abb2bf";
          "@constant".fg = "#98c379";
          "@constant.builtin".fg = "#98c379";
          "@boolean".fg = "#98c379";
          "@number".fg = "#98c379";
          "@number.float".fg = "#98c379";
          "@character".fg = "#98c379";
          "@string.regexp".fg = "#98c379";
          "@type.builtin".fg = "#e5c07b";
          "@module.builtin".fg = "#e5c07b";
          "@function.builtin".fg = "#61afef";
          "@comment.todo".fg = "#e86671";

          # "@my_important".fg = "#e86671";

          "@lsp.type.parameter".fg = "#abb2bf";
          "@lsp.type.property".fg = "#abb2bf";
          "@lsp.type.const".fg = "#98c379";
          "@lsp.type.number".fg = "#98c379";
          "@lsp.type.enumMember".fg = "#98c379";
          "@lsp.type.builtinType".fg = "#e5c07b";
          "@lsp.typemod.variable.defaultLibrary".fg = "NONE";

          # "@lsp.mod.controlFlow".fg = "#e86671";
          # "@lsp.typemod.keyword.controlFlow".fg = "#e86671";
          "@lsp.typemod.operator.controlFlow".fg = "#e86671";
        };
      };
    };
  };
}
