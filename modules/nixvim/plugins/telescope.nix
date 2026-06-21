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

          # border = false;
          borderchars = [ "-" "|" " " "|" "|" "|" "|" "|" ];

          layout_config = {
            width.padding = 0;
            height.padding = 0;
          };

          mappings = {
            i = {
              "<C-v>".__raw = "function() vim.cmd 'normal! p' vim.cmd 'startinsert!' end";
              "<C-Backspace>".__raw = "function() vim.cmd 'normal! db' vim.cmd 'startinsert!' end";
            };
          };
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
      enabledExtensions = [ "remote-sshfs" ];
    };
  };
}
