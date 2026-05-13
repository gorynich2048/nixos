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
          cmdline = {
            keymap = {
              preset = "inherit";
              "<Tab>" = [ "show" "select_and_accept" ];
              "<CR>" = [ "accept_and_enter" "fallback" ];
            };
            completion = {
              list.selection.preselect = false;
              menu.auto_show = true;
              # Does not work
              ghost_text = {
                enabled = true;
                show_with_selection = false;
                show_without_selection = true;
                show_with_menu = true;
                show_without_menu = true;
              };
            };
          };

          snippets.preset = "luasnip";

          completion = {
            list.selection.preselect = false;
            documentation = {
              auto_show = true;
              auto_show_delay_ms = 0;
            };
            menu.max_height = 30;
            ghost_text = {
              enabled = true;
              show_with_selection = false;
              show_without_selection = true;
              show_with_menu = true;
              show_without_menu = true;
            };
          };

          keymap = {
            preset = "none";

            "<Down>" = [ "select_next" "fallback" ];
            "<Up>" = [ "select_prev" "fallback" ];
            "<Tab>" = [ "select_and_accept" "fallback" ];
            "<CR>" = [ "accept" "fallback" ];
            "<PageDown>" = [ "scroll_documentation_down" "fallback" ];
            "<PageUp>" = [ "scroll_documentation_up" "fallback" ];
          };

          sources = {
            default = [
              "lsp"
              "path"
              "snippets"
              "buffer"
            ];
          };
        };
      };
    };
  };
}
