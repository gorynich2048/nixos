{ pkgs, ... }: {
  programs.nixvim = {
    plugins = {
      dap = {
        enable = true;
        extensions = {
        };
        adapters = {
          executables = {
            lldb = {
              command = "${pkgs.lldb}/bin/lldb-dap";
            };
          };
        };
      };
      dap-virtual-text.enable = true;
      dap-ui = {
        enable = true;
        settings.controls.enabled = false;
      };
    };
  };
}
