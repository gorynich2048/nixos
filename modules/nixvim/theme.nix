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
          "@spell".fg = "NONE";
          "@nospell".fg = "NONE";
          "@lsp.typemod.variable.defaultLibrary".fg = "NONE";
        }
        // (let red = "#e86671"; in {
          IncSearch.bg = red;
          CurSearch.bg = red;
          TelescopeMatching.fg = red;
          BlinkCmpLabelMatch.fg = red;
          "@comment.todo".fg = red;
          "@lsp.typemod.operator.controlFlow".fg = red;
          # "@my_important".fg = red;
        })
        //
        (let green = "#98c379"; in {
          "@constant".fg = green;
          "@constant.builtin".fg = green;
          "@boolean".fg = green;
          "@number".fg = green;
          "@number.float".fg = green;
          "@character".fg = green;
          "@string.regexp".fg = green;
          "@lsp.type.const".fg = green;
          "@lsp.type.number".fg = green;
          "@lsp.type.enumMember".fg = green;
        })
        // (let yellow = "#e5c07b"; in {
          "@type.builtin".fg = yellow;
          "@module.builtin".fg = yellow;
          "@lsp.type.builtinType".fg = yellow;
        })
        // (let blue = "#61afef"; in {
          CurrentScope.fg = blue;
          FloatBorder.fg = blue;
          TelescopeBorder.fg = blue;
          TelescopePromptBorder.fg = blue;
          TelescopeResultsBorder.fg = blue;
          TelescopePreviewBorder.fg = blue;
          "@function.builtin".fg = blue;
        })
        // (let magenta = "#c678dd"; in {
        })
        // (let bluegreen = "#56b6c2"; in {
        })
        // (let dark = "#6c7380"; in {
          "@comment".fg = dark;
          "@lsp.type.comment".fg = dark;
        })
        // (let grey = "#abb2bf"; in {
          Search.bg = grey;
          "@variable.member".fg = grey;
          "@property".fg = grey;
          "@lsp.type.property".fg = grey;
        })
        // (let white = "#ebf2ff"; in {
          "@variable.parameter".fg = white;
          "@variable.parameter.builtin".fg = white;
          "@variable.builtin".fg = white;
          "@lsp.type.parameter".fg = white;
          "@character.special".fg = white;
        });
      };
    };
  };
}
