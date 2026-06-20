{
  imports = [
    ./dap.nix
    ./indent-blankline.nix
    ./lsp.nix
    ./oil.nix
    # ./ollama.nix
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
      substitute = {
        enable = true;
        settings = {
          on_substitute.__raw = "require('yanky.integration').substitute()";
        };
      };
      mini-ai.enable = true; # extended a/i textobjects
      sleuth.enable = true; # auto indent
      vim-surround.enable = true;
      treesitter-context = {
        enable = true;
        settings = {
          max_lines = 10;
          multiline_threshold = 1;
        };
      };
      # treesitter-textobjects.enable = true;
      yanky.enable = true;
      noice = {
        enable = true;
        settings = {
          views.cmdline_popup = {
            border.style = "single";
            position.row = -10;
            position.col = 25;
          };
          messages.enabled = false;
          popupmenu.enabled = false;
          notify.enabled = false;
          lsp.progress.enabled = false;
          lsp.hover.enabled = false;
          lsp.signature.enabled = false;
          lsp.message.enabled = false;
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
      csvview.enable = true;
    };
  };
}
