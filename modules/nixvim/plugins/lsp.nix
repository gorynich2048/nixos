{ ... }: {
  environment.sessionVariables.PATH = [
    "/home/user/.cargo/bin/"
  ];

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
        nixd = {
          enable = true;
          settings = {
            nixpkgs.expr = "import <nixpkgs> {}";
            # options = {
            #   nixos.expr = ''(builtins.getFlake "/home/user/flakes/system").nixosConfigurations.local.options'';
            #   nixvim.expr = ''(import (builtins.fetchGit "https://github.com/nix-community/nixvim")).packages.x86_64-linux.options-json.options'';
            # };
          };
        };
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
        wgsl_analyzer = {
          enable = true;
        };
        java_language_server.enable = true;
      };
    };
  };
}
