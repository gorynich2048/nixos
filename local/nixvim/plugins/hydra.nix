{ pkgs, ... }: {
  programs.nixvim = {
    plugins.hydra = {
      enable = true;
      hydras = [
        {
          body = "<leader>d";
          mode = "n";
          config = {
            color = "pink";
          };
          name = "debug";
          heads = [
            [ "c" { __raw = ''
              function()
                require('dap').continue()
              end
            ''; } {} ]
            [ "t" { __raw = ''
              function()
                require('dap').terminate()
              end
            ''; } {} ]
            [ "i" { __raw = ''
              function()
                require('dap').step_into()
              end
            ''; } {} ]
            [ "o" { __raw = ''
              function()
                require('dap').step_out()
              end
            ''; } {} ]
            [ "n" { __raw = ''
              function()
                require('dap').step_over()
              end
            ''; } {} ]
            [ "r" { __raw = ''
              function()
                require('dap').repl.toggle()
              end
            ''; } {} ]
            [ "b" { __raw = ''
              function()
                require('dap').toggle_breakpoint()
              end
            ''; } {} ]
          ];
        }
      ];
      settings = {
        foreign_keys = "run";
        invoke_on_body = true;
      };
    };
  };
}
