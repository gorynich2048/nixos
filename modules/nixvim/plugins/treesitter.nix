{
  programs.nixvim = {
    plugins = {
      treesitter = {
        enable = true;

        # Highlight Lua and VimScript inside nix expressions
        nixvimInjections = true;

        folding = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
        };
      };

      # Highlight Bash inside nix expressions
      hmts.enable = true;
    };
  };
}
