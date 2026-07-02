{
  # For wgsl_analyzer
  # environment.sessionVariables.PATH = [
  #   "/home/user/.cargo/bin/"
  # ];

  programs.nixvim = {
    plugins.lsp = {
      enable = true;
      servers = {
        nixd.enable = true;
        clangd.enable = true;
        rust_analyzer = {
          enable = true;
          package = null;
          installCargo = false;
          installRustc = false;
          settings = {
            cargo = {
              features = "all";
              # targetDir = "target_rust_analyzer";
            };
          };
        };
        wgsl_analyzer = {
          enable = true;
        };
      };
    };
  };
}
