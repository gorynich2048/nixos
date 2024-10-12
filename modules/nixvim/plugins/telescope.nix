{
  programs.nixvim = {
    plugins.telescope = {
      enable = true;

      keymaps = {
        # Find files using Telescope command-line sugar.
        "<leader>fg" = "live_grep";
        "<leader>ff" = "find_files";
        "<leader>b" = "buffers";
        "<leader>o" = "oldfiles";
        "<leader>fd" = "diagnostics";
      };

      settings = { 
        defaults = {
          file_ignore_patterns = [
            "^.git/"
            "^.secret/"
            "^.env/"
            "^.envrc/"
          ];
          layout_strategy = "vertical";
          sorting_strategy = "ascending";
          border = false;
          hidden = true;
          layout_config = {
            prompt_position = "top";
            height = 0.999;
            width = 0.999;
          };
          set_env.COLORTERM = "truecolor";
          mappings = {
            i = {
              # "<Esc>" = "close";
              # "<C-j>".__raw = "require('telescope.actions').move_selection_next";
              # "<Tab>".__raw = "require('telescope.actions').move_selection_next";
              # "<C-d>".__raw = "require('telescope.actions').results_scrolling_down";
              # "<C-k>".__raw = "require('telescope.actions').move_selection_previous";
              # "<S-Tab>".__raw = "require('telescope.actions').move_selection_previous";
              # "<C-u>".__raw = "require('telescope.actions').results_scrolling_up";
              # "<C-l>".__raw = "require('telescope.actions').select_default";
            };
          };
        };

        pickers = {
          find_files.hidden = true;
          live_grep.hidden = true;
        };
      };
    };
  };
}
