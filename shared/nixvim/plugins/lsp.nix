{ pkgs, ... }: {
  # For wgsl_analyzer
  # environment.sessionVariables.PATH = [
  #   "/home/user/.cargo/bin/"
  # ];

  programs.nixvim = {
    plugins.lsp = {
      enable = true;
      keymaps = {
        lspBuf = {
          "gd" = "definition";
          "gr" = "references";
          "gt" = "type_definition";
          "gi" = "implementation";
          "<leader>a" = "code_action";
          "<leader>r" = "rename";
          # "<leader>i" = "incoming_calls";
          # "<leader>o" = "outgoing_calls";
          "H" = "hover";
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
        clangd.enable = true;
        cmake.enable = true;
        rust_analyzer = {
          enable = true;
          installCargo = true;
          installRustc = true;
          settings = {
            cargo = {
              features = "all";
              targetDir = "target_rust_analyzer";
            };
          };
        };
        wgsl_analyzer = {
          enable = true;
          package = pkgs.fetchFromGitHub {
            owner = "wgsl-analyzer";
            repo = "wgsl-analyzer";
            rev = "4c56b1435d30cd45d8aee52297bbf68ed5bb3beb";
            sha256 = "sha256-FoVvVoYPWm1e4bV287zIS3JYtuNknPs25rLPygMUqwo=";
          };
        };
        java_language_server.enable = true;
      };
    };
  };
}
