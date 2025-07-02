# `.vscode/launch.json`:
# ```json
# {
#     "version": "0.2.0",
#     "configurations": [
#         {
#             "type": "lldb",
#             "request": "launch",
#             "name": "Debug with lldb",
#             "args": ["arg1", "arg2"],
#             "program": "${workspaceFolder}/path/to/executable"
#         }
#     ]
# }
# ```
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
      hydra = {
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
  };
}
