{ lib, config, ... }: {
  programs.nixvim = {
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    userCommands = {
      Cd.command.__raw = "require('oil.actions').cd.callback";
      Clear.command.__raw = ''
        function()
          vim.opt_local.scrollback = 1
          vim.api.nvim_chan_send(vim.b.terminal_job_id, "clear\n")
          vim.defer_fn(function() vim.opt_local.scrollback = -1 end, 10)
        end
      '';
      ToggleBufMarks.command.__raw = ''
        function()
          local current_state = vim.b.disable_global_marks or false
          vim.b.disable_global_marks = not current_state
          
          if vim.b.disable_global_marks then
            print("Marks tracking DISABLED for this buffer")
          else
            print("Marks tracking ENABLED for this buffer")
          end
        end
      '';
    };

    keymaps = let
      # :h map-modes
      operator = 
        lib.mapAttrsToList (key: action: {
          mode = [ "x" "o" ];
          inherit action key;
        }) {
          "l".__raw = "function() vim.cmd('normal! ^vt=h') end";
          "r".__raw = "function() vim.cmd('normal! ^f=llvt;') end";
          "if".__raw = "function() require('nvim-treesitter-textobjects.select').select_textobject('@function.inner', 'textobjects') end";
          "af".__raw = "function() require('nvim-treesitter-textobjects.select').select_textobject('@function.outer', 'textobjects') end";
          "is".__raw = "function() require('nvim-treesitter-textobjects.select').select_textobject('@class.inner', 'textobjects') end";
          "as".__raw = "function() require('nvim-treesitter-textobjects.select').select_textobject('@class.outer', 'textobjects') end";
          "il".__raw = "function() require('nvim-treesitter-textobjects.select').select_textobject('@local.scope', 'locals') end";
          "al".__raw = "function() require('nvim-treesitter-textobjects.select').select_textobject('@local.scope', 'locals') end";
        };
      normal_operator = 
        lib.mapAttrsToList (key: action: {
          mode = [ "n" "x" "o" ];
          inherit action key;
        }) {
          "]f".__raw = "function() require('nvim-treesitter-textobjects.move').goto_next_start('@function.outer', 'textobjects') end";
          "]F".__raw = "function() require('nvim-treesitter-textobjects.move').goto_next_end('@function.outer', 'textobjects') end";
          "[f".__raw = "function() require('nvim-treesitter-textobjects.move').goto_previous_start('@function.outer', 'textobjects') end";
          "[F".__raw = "function() require('nvim-treesitter-textobjects.move').goto_previous_end('@function.outer', 'textobjects') end";
          "]s".__raw = "function() require('nvim-treesitter-textobjects.move').goto_next_start('@class.outer', 'textobjects') end";
          "]S".__raw = "function() require('nvim-treesitter-textobjects.move').goto_next_end('@class.outer', 'textobjects') end";
          "[s".__raw = "function() require('nvim-treesitter-textobjects.move').goto_previous_start('@class.outer', 'textobjects') end";
          "[S".__raw = "function() require('nvim-treesitter-textobjects.move').goto_previous_end('@class.outer', 'textobjects') end";

          ";".__raw = "require('nvim-treesitter-textobjects.repeatable_move').repeat_last_move_next";
          ",".__raw = "require('nvim-treesitter-textobjects.repeatable_move').repeat_last_move_previous";
        };
      normal_operator_expr = 
        lib.mapAttrsToList (key: action: {
          mode = [ "n" "x" "o" ];
          options.expr = true;
          inherit action key;
        }) {
          "f".__raw = "require('nvim-treesitter-textobjects.repeatable_move').builtin_f_expr";
          "F".__raw = "require('nvim-treesitter-textobjects.repeatable_move').builtin_F_expr";
          "t".__raw = "require('nvim-treesitter-textobjects.repeatable_move').builtin_t_expr";
          "T".__raw = "require('nvim-treesitter-textobjects.repeatable_move').builtin_T_expr";
          "n" = "v:searchforward ? 'n' : 'N'";
          "N" = "v:searchforward ? 'N' : 'n'";
        };
      buffer_path = "%:s?term:.*??:s?oil://??:p";
      normal =
        lib.mapAttrsToList (key: action: {
          mode = "n";
          inherit action key;
        }) {
          "<Space>" = "<NOP>";
          "ZZ" = "<NOP>";
          "<Esc>" = "<cmd>noh<CR>";
          "<C-s>" = "<cmd>w<CR>";
          "<Backspace>" = "<cmd>Oil<CR>";
          "H" = "zH";
          "L" = "zL";
          "k" = ".";
          "\\" = "/\\V<C-r>\"<CR>";
          "yp" = "<cmd>let @+=expand(\"${buffer_path}\")<CR>";
          "s".__raw = "require('substitute').operator";
          "ss".__raw = "require('substitute').line";
          "S".__raw = "require('substitute').eol";
          "sx".__raw = "require('substitute.exchange').operator";
          "sxx".__raw = "require('substitute.exchange').line";
          "sxc".__raw = "require('substitute.exchange').cancel";
          "*" = ":let @/='\\<'.expand('<cword>').'\\>' | set hlsearch | let v:searchforward=1<CR>";

          "gw" = "<cmd>Oil .<CR>";
          "gh" = "<cmd>Oil ~/!/<CR>";
          "gt" = "<cmd>b term_root<CR>";
          "gs" = "<cmd>G<CR>:only<CR>";
          "gl" = "<cmd>G l<CR>:only<CR>";
          "gf" = "gFzz";
          "gd" = "gdzz";
          "gco" = "oa<Esc><cmd>norm gcc<CR>A<BS>";
          "gcO" = "Oa<Esc><cmd>norm gcc<CR>A<BS>";

          # "n" = "nzz";
          # "N" = "Nzz";
          # "<C-i>" = "<C-i>zz";
          "l" = "M<C-u>";
          "h" = "M<C-d>zz";
          "p" = "<Plug>(YankyPutAfter)";
          "P" = "<Plug>(YankyPutBefore)";
          "gp" = "<Plug>(YankyGPutAfter)";
          "gP" = "<Plug>(YankyGPutBefore)";

          "<C-p>" = "<Plug>(YankyPutIndentAfterLinewise)";
          "<C-n>" = "mao<Esc>`a";
          "<C-u>" = "maO<Esc>`a";
          "<C-j>" = "<cmd>t.<CR>";
          "<C-d>" = "\"_dd";
          "<C-h>" = "<C-w>w";
          "<C-l>" = "<C-w>W";
          "<C-c>" = "<C-w>c";

          "<C-Up>" = "<Plug>(YankyPreviousEntry)";
          "<C-Down>" = "<Plug>(YankyNextEntry)";

          "<S-Up>" = "<cmd>m .-2<CR>==";
          "<S-Down>" = "<cmd>m .+1<CR>==";

          "<leader>t" = "<cmd>e term://${buffer_path}:h//$SHELL<CR>i";
          "<leader>e".__raw = "vim.diagnostic.open_float";
          "<leader>s" = "<cmd>Spectre<CR>";
          "<leader>cd" = "<cmd>Cd<CR>:te<CR>:f term_root<CR>";
          "<leader>cl" = "<cmd>Clear<CR>";
          "<leader>cm" = "<cmd>ToggleBufMarks<CR>";

          "<leader>f" = "<cmd>Telescope find_files<CR>";
          "<leader>F" = "<cmd>Telescope find_files cwd=${buffer_path}:h<CR>";
          "<leader>l" = "<cmd>Telescope live_grep<CR>";
          "<leader>L" = "<cmd>Telescope live_grep cwd=${buffer_path}:h<CR>";
          "<leader>b" = "<cmd>Telescope buffers<CR>";

          "<leader>y" = "\"+y";
          "<leader>Y" = "\"+Y";
          "<leader>p" = "\"+p";
          "<leader>P" = "\"+P";

          "<leader>mc" = "<cmd>RemoteSSHFSConnect<CR>";
          "<leader>md" = "<cmd>RemoteSSHFSDisconnect<CR>";
          "<leader>mf" = "<cmd>RemoteSSHFSFindFiles<CR>";
          "<leader>ml" = "<cmd>RemoteSSHFSLiveGrep<CR>";
        };
      visual =
        lib.mapAttrsToList (key: action: {
          mode = "x";
          inherit action key;
        }) {
          "l" = "M<C-u>";
          "h" = "M<C-d>zz";
          "H" = "zH";
          "L" = "zL";
          ">" = ">gv";
          "<" = "<gv";
          "s".__raw = "require('substitute').visual";

          "p" = "<Plug>(YankyPutAfter)";
          "P" = "<Plug>(YankyPutBefore)";
          "gp" = "<Plug>(YankyGPutAfter)";
          "gP" = "<Plug>(YankyGPutBefore)";
          "x".__raw = "require('substitute.exchange').visual";

          "<C-d>" = "\"_d";
          "<C-j>" = ":t'><CR>";
          "<S-Up>" = ":m '<-2<CR>gv=gv";
          "<S-Down>" = ":m '>+1<CR>gv=gv";

          "<leader>y" = "\"+y";
          "<leader>p" = "\"+p";

          "<leader>s" = ":sort<CR>";
          "<leader>a".__raw = "vim.lsp.buf.code_action";
        };
      insert =
        lib.mapAttrsToList (key: action: {
          mode = "!";
          inherit action key;
        }) {
          "<C-Backspace>" = "<C-w>";
          "<C-v>" = "<C-r>" + (if config.networking.hostName == "local" then "+" else "\"");
        };
      terminal =
        lib.mapAttrsToList (key: action: {
          mode = "t";
          inherit action key;
        }) {
          "<C-Backspace>" = "<C-w>";
          "<C-v>" = "<C-\\><C-o>p";

          "<Esc>" = "<C-\\><C-n>";
          "<C-i>" = "<C-\\><C-n><C-i>";
          "<C-o>" = "<C-\\><C-n><C-o>";
          "<C-Esc>" = "<Esc>";
          "<Tab>" = "<Tab>";
        };
    in
      (operator ++ normal_operator ++ normal_operator_expr ++ normal ++ visual ++ insert ++ terminal);

    extraConfigLua = ''
      -- Use lowercase for global marks and uppercase for local marks.
      local low = function(i) return string.char(97+i) end
      local upp = function(i) return string.char(65+i) end

      for i=0,25 do vim.keymap.set("n", "m"..low(i), "`"..upp(i)) end
      for i=0,25 do vim.keymap.set("n", "M"..low(i), "m"..upp(i)) end
    '';
  };
}
