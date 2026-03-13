{
  programs.nixvim = {
    opts.completeopt = [
      "menu"
      "menuone"
      "noselect"
    ];

    plugins = {
      # Handle snippet expansion (if, for, bevy plugin, ...)
      luasnip.enable = true;

      # Handle completion menu
      blink-cmp = {
        enable = true;

        settings = {
          cmdline.enabled = false;
          snippets.preset = "luasnip";

          completion = {
            list.selection.preselect = false;
            documentation = {
              auto_show = true;
              auto_show_delay_ms = 0;
            };
            menu.max_height = 30;
          };

          keymap = {
            "<Down>" = [ "select_next" "fallback" ];
            "<Up>" = [ "select_prev" "fallback" ];
            "<S-Down>" = [ "scroll_documentation_down" "fallback" ];
            "<S-Up>" = ["scroll_documentation_up" "fallback" ];
            "<CR>" = [ "select_and_accept" "fallback" ];
          };

          sources = {
            default = [
              "lsp"
              "path"
              "snippets"
            ];
          };
        };
      };
    };
  };
}
