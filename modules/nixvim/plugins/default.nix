{
  imports = [
    ./cmp.nix
    ./dap.nix
    ./indent-blankline.nix
    ./lsp.nix
    ./oil.nix
    ./ollama.nix
    ./telescope.nix
    ./treesitter.nix
  ];

  programs.nixvim = {
    plugins = {
      direnv.enable = true;
      fugitive.enable = true;
      web-devicons.enable = true;
      crates.enable = true;
      spectre = {
        enable = true;
        settings.open_cmd = "enew";
      };

      sleuth.enable = true; #auto indent
      vim-surround.enable = true;
      treesitter-context.enable = true;
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
      nvim-autopairs.enable = true;
    };
  };
}
