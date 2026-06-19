{
  programs.nixvim = {
    plugins = {
      oil = {
        enable = true;
        settings = {
          # columns = [
          #   "icon"
          #   "permissions"
          #   "size"
          # ];
          view_options = {
            show_hidden = true;
          };
          use_default_keymaps = false;
          keymaps = {
            "<CR>" = "actions.select";
            "<ESC>" = "actions.refresh";
            "<leader>p" = "actions.preview";
          };
          cleanup_delay_ms = false;
          # experimental_watch_for_changes = true;
          keymaps_help.border = "none";
          float.border = "none";
          preview.border = "none";
          ssh.border = "none";
        };
      };
    };
  };
}
