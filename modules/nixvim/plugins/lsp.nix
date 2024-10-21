{
  programs.nixvim = {
    plugins.lsp = {
      enable = true;
      keymaps = {
        lspBuf = {
          "gd" = "definition";
          "gr" = "references";
          "gt" = "type_definition";
          "gi" = "implementation";
          "ga" = "code_action";
          "<leader>r" = "rename";
          # "<leader>i" = "incoming_calls";
          # "<leader>o" = "outgoing_calls";
          "K" = "hover";
        };
      };
      servers = {
        lua_ls.enable = true;
        nixd.enable = true;
        # nil_ls.enable = true;
        clangd.enable = true;
        cmake.enable = true;
        rust_analyzer = {
          enable = true;
          installCargo = true;
          installRustc = true;
          settings = {
            cargo.features = "all";
          };
        };
        java_language_server.enable = true;
      };
    };
  };
}
