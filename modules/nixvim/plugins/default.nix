{
  imports = [
    ./treesitter.nix
    ./cmp.nix
    ./lsp.nix
    ./ollama.nix
    ./neotest.nix
    ./dap.nix
    ./himalaya.nix
    ./hydra.nix
  ];

  programs.nixvim = {
    plugins = {
      comment.enable = true;
      sleuth.enable = true; #auto indent
      fugitive.enable = true;
      spectre.enable = true;
      cmake-tools.enable = true;
      vim-surround.enable = true;
      treesitter-context.enable = true;
      web-devicons.enable = true;
      fzf-lua = {
        enable = true;
        profile = "skim";
        settings = {
          winopts = {
            border = "none";
            fullscreen = true;
          };
        };
      };
      oil = {
        enable = true;
        settings = {
          view_options = {
            show_hidden = true;
          };
          keymaps = {
            "-" = false;
            "`" = false;
            "<S-Tab>" = "actions.cd";
          };
          cleanup_delay_ms = false;
          # experimental_watch_for_changes = true;
          keymaps_help.border = "none";
          float.border = "none";
          preview.border = "none";
          ssh.border = "none";
        };
      };
      indent-blankline = {
        enable = true;
        settings = {
          scope = {
            show_start = false;
            show_end = false;
          };
        };
      };
      gitsigns = {
        enable = true;
        settings.signs = {
          add.text = "+";
          change.text = "~";
        };
      };
      nvim-colorizer = {
        enable = true;
        userDefaultOptions.names = false;
      };
      # nvim-autopairs.enable = true;
      # refactoring.enable = true;
      # rustaceanvim = {
      #   enable = true;
      #   tools = {
      #     floatWinConfig = { border = ["" "" "" " " "" "" "" " "]; };
      #   };
      # };
    };
  };
}
