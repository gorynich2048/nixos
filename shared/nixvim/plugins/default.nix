{
  imports = [
    ./oil.nix
    ./treesitter.nix
    ./telescope.nix
    ./cmp.nix
    ./lsp.nix
    ./ollama.nix
    ./neotest.nix
    ./dap.nix
    ./hydra.nix
  ];

  programs.nixvim = {
    plugins = {
      comment.enable = true;
      sleuth.enable = true; #auto indent
      fugitive.enable = true;
      spectre.enable = true;
      vim-surround.enable = true;
      treesitter-context.enable = true;
      web-devicons.enable = true;
      hex.enable = true;
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
      colorizer = {
        enable = true;
        settings.user_default_options.names = false;
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
