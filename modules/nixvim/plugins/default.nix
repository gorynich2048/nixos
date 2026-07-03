{
  imports = [
    ./dap.nix
    ./lsp.nix
    ./oil.nix
    ./telescope.nix
    ./treesitter.nix
  ];

  programs.nixvim = {
    plugins = {
      direnv.enable = true;
      fugitive.enable = true;
      web-devicons.enable = true;
      crates.enable = true;
      sleuth.enable = true; # autodetect tabstop for <Tab> key
      spectre = {
        enable = true;
        settings.open_cmd = "enew";
      };
      substitute = {
        enable = true;
        settings = {
          on_substitute.__raw = "require('yanky.integration').substitute()";
        };
      };
      mini-ai = {
        enable = true; # extended a/i textobjects
        settings = {
          custom_textobjects = {
            c.__raw = "require('mini.ai').gen_spec.function_call()";
          };
        };
      };
      vim-surround.enable = true;
      treesitter-context = {
        enable = true;
        settings = {
          max_lines = 10;
          multiline_threshold = 1;
        };
      };
      treesitter-textobjects.enable = true;
      yanky.enable = true;
      gitsigns = {
        enable = true;
        settings.signs = {
          add.text = "+";
          change.text = "~";
        };
      };
      colorizer = {
        enable = true;
        settings.user_default_options.names = false;
      };
      indent-blankline = {
        enable = true;
        settings = {
          scope = {
            show_start = false;
            show_end = false;
            highlight = "CurrentScope";
          };
        };
      };
      # nvim-autopairs.enable = true;
      csvview.enable = true;
    };
  };
}
