{
  programs.nixvim = {
    plugins.telescope = {
      enable = true;

      settings = { 
        defaults = {
          file_ignore_patterns = [
            "^.git/"
            "^.secret/"
            "^.env"
            "^.envrc"
            "Cargo.lock"
          ];
          layout_strategy = "vertical";
          sorting_strategy = "ascending";

          borderchars = [ "-" "" "" "" "" "" "" "" ];

          layout_config = {
            prompt_position = "top";
            height = 0.999;
            width = 0.999;
          };
          set_env.COLORTERM = "truecolor";
          mappings = {
            i = {
              "<C-v>".__raw = "function() vim.cmd 'normal! p' vim.cmd 'startinsert!' end";
              "<C-Backspace>".__raw = "function() vim.cmd 'normal! bdw' vim.cmd 'startinsert!' end";
            };
          };

          # Search for hidden files
          hidden = true;
        };

        pickers = {
          # Search for hidden files
          find_files.hidden = true;
          live_grep.hidden = true;
        };
      };

      extensions = {
        fzf-native.enable = true;
        ui-select.enable = true;
      };
    };
  };
}
