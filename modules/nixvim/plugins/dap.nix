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
#             "cwd": "${workspaceFolder}",
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
              invoke_on_body = true;
              color = "pink";
            };
            name = "debug";
            heads = [
              [ "c" { __raw = ''
              function()
                require('dap').continue()
              end
              ''; } { nowait = true; } ]
              [ "t" { __raw = ''
              function()
                require('dap').terminate()
              end
              ''; } {} ]
              [ "b" { __raw = ''
              function()
                require('dap').toggle_breakpoint()
              end
              ''; } {} ]
              [ "r" { __raw = ''
              function()
                require('dap').repl.open({},"enew")
              end
              ''; } { exit = true; } ]
              [ "<Esc>" { __raw = ''
              function() end
              ''; } { exit = true; } ]

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

              [ "d" { __raw = ''
              function()
                require('dap').down()
              end
              ''; } { nowait = true; } ]
              [ "u" { __raw = ''
              function()
                require('dap').up()
              end
              ''; } {} ]
              [ "f" { __raw = ''
              function()
                require('dap').focus_frame()
              end
              ''; } { nowait = true; } ]

              [ "F" { __raw = ''
              function()
                local widgets = require('dap.ui.widgets')
                widgets.centered_float(widgets.frames)
              end
              ''; } { nowait = true; } ]
              [ "S" { __raw = ''
              function()
                local widgets = require('dap.ui.widgets')
                widgets.centered_float(widgets.scopes)
              end
              ''; } { nowait = true; } ]
              [ "T" { __raw = ''
              function()
                local widgets = require('dap.ui.widgets')
                widgets.centered_float(widgets.threads)
              end
              ''; } { nowait = true; } ]
              [ "E" { __raw = ''
              function()
                local widgets = require('dap.ui.widgets')
                widgets.centered_float(widgets.expressions)
              end
              ''; } { nowait = true; } ]
              [ "I" { __raw = ''
              function()
                local widgets = require('dap.ui.widgets')
                widgets.centered_float(widgets.expressions)
              end
              ''; } { nowait = true; } ]
            ];
          }
        ];
      };
    };
  };
}
