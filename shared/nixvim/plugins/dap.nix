{ pkgs, ... }: {
  programs.nixvim = {
    plugins = {
      dap = {
        enable = true;
        extensions = {
          dap-virtual-text.enable = true;
          dap-ui = {
            enable = true;
            controls.enabled = false;
          };
        };
        adapters = {
          executables = {
            lldb = {
              command = "${pkgs.lldb}/bin/lldb-dap";
            };
          };
        };
      };
    };
  };
}
