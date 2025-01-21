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
          "<leader>ca" = "code_action";
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
            cargo.features = "all";
          };
        };
        wgsl_analyzer = {
          enable = true;
          package = pkgs.fetchFromGitHub {
            owner = "wgsl-analyzer";
            repo = "wgsl-analyzer";
            rev = "a54d6a959518319655c1645d1212747e3b065e8a";
            sha256 = "sha256-ERpFr120bSfadYMnkNbNquppmF+Xrg9t/0xk87INq2A=";
          };
        };
        java_language_server.enable = true;
      };
    };
  };
}
