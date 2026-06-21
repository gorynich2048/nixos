{
  programs.nixvim = {
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
          FloatBorder.fg = "#61afef";
          TelescopeBorder.fg = "#61afef";
          TelescopePromptBorder.fg = "#61afef";
          TelescopeResultsBorder.fg = "#61afef";
          TelescopePreviewBorder.fg = "#61afef";

          "@spell".fg = "NONE";
          "@nospell".fg = "NONE";

          "@variable.parameter".fg = "#abb2bf";
          "@variable.parameter.builtin".fg = "#abb2bf";
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
