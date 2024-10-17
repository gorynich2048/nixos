{ lib, pkgs, ... }: {
  imports = [
    ./treesitter.nix
    ./telescope.nix
    ./cmp.nix
    ./lsp.nix
    ./ollama.nix
    ./neotest.nix
  ];

  programs.nixvim = {
    plugins = {
      comment.enable = true;
      sleuth.enable = true; #auto indent
      fugitive.enable = true;
      spectre.enable = true;
      dap = {
        enable = true;
        adapters = {
          executables = {
            lldb = {
              command = "${pkgs.lldb}/bin/lldb-dap";
            };
            cppdbg = {
              command = "${pkgs.vscode-extensions.ms-vscode.cpptools}/share/vscode/extensions/ms-vscode.cpptools/debugAdapters/bin/OpenDebugAD7";
            };
          };
        };
        # configurations = {
        #   c = [
        #     {
        #       name = "lldb";
        #       request = "launch";
        #       type = "lldb";
        #     }
        #     {
        #       name = "cppdbg";
        #       request = "launch";
        #       type = "cppdbg";
        #     }
        #   ];
        # };
        # configurations.cpp = configurations.c;
        # configurations.rust = configurations.c;
      };
      oil = {
        enable = true;
        settings = {
          view_options = {
            show_hidden = true;
          };
          cleanup_delay_ms = false;
          experimental_watch_for_changes = true;
          keymaps_help.border = "none";
          float.border = "none";
          preview.border = "none";
          ssh.border = "none";
        };
      };
      indent-blankline = {
        enable = true;
        settings = {
          scope = {
            show_start = false;
            show_end = false;
          };
        };
      };
      gitsigns = {
        enable = true;
        settings.signs = {
          add.text = "+";
          change.text = "~";
        };
      };
      nvim-colorizer = {
        enable = true;
        userDefaultOptions.names = false;
      };
      # nvim-autopairs.enable = true;
      # refactoring.enable = true;
      # rustaceanvim = {
      #   enable = true;
      #   tools = {
      #     floatWinConfig = { border = ["" "" "" " " "" "" "" " "]; };
      #   };
      # };
    };
  };
}
