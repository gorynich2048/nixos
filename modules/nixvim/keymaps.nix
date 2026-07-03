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
          inherit key action;
        }) {
          "l".__raw = "function() vim.cmd('normal! ^vf=F h') end";
          "r".__raw = "function() vim.cmd('normal! ^f=f lvt;') end";
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
          inherit key action;
        }) {
          ")".__raw = "function() require('nvim-treesitter-textobjects.move').goto_next_start('@function.outer', 'textobjects') end";
          "(".__raw = "function() require('nvim-treesitter-textobjects.move').goto_previous_start('@function.outer', 'textobjects') end";
          "]".__raw = "function() require('nvim-treesitter-textobjects.move').goto_next_start('@class.outer', 'textobjects') end";
          "[".__raw = "function() require('nvim-treesitter-textobjects.move').goto_previous_start('@class.outer', 'textobjects') end";
        };
      normal_operator_expr = 
        lib.mapAttrsToList (key: action: {
          mode = [ "n" "x" "o" ];
          options.expr = true;
          inherit key action;
        }) {
          "f".__raw = "require('nvim-treesitter-textobjects.repeatable_move').builtin_f_expr";
          "F".__raw = "require('nvim-treesitter-textobjects.repeatable_move').builtin_F_expr";
          "t".__raw = "require('nvim-treesitter-textobjects.repeatable_move').builtin_t_expr";
          "T".__raw = "require('nvim-treesitter-textobjects.repeatable_move').builtin_T_expr";
          "n" = "v:searchforward ? 'n' : 'N'";
          "N" = "v:searchforward ? 'N' : 'n'";
          "<Down>" = "v:count > 1 ? \"m'\" . v:count . 'j' : 'j'";
          "<Up>" = "v:count > 1 ? \"m'\" . v:count . 'k' : 'k'";
        };
      buffer_path = "%:s?term:.*??:s?oil://??:p";
      clipboard = if config.networking.hostName == "local" then "+" else "\"";
      normal =
        lib.mapAttrsToList (key: action: {
          mode = "n";
          inherit key action;
        }) {
          "<Space>" = "<NOP>";
          "ZZ" = "<NOP>";
          "<Esc>" = "<Plug>(clever-f-reset)<cmd>noh<CR>";
          "<C-s>" = "<cmd>w<CR>";
          "<Backspace>" = "<cmd>Oil<CR>";
          "H" = "zL";
          "L" = "zH";
          "k" = ".";
          "\\" = "/\\V<C-r>\"<CR>";
          "yp" = "<cmd>let @${clipboard}=expand(\"${buffer_path}\")<CR>";
          "s" = "\"_s";

          "gw" = "<cmd>Oil .<CR>";
          "gh" = "<cmd>Oil ~/!/<CR>";
          "gco" = "oa<Esc><cmd>norm gcc<CR>A<BS>";
          "gcO" = "Oa<Esc><cmd>norm gcc<CR>A<BS>";
          "gf" = "gF";
          "gs".__raw = "require('substitute').operator";
          "gss".__raw = "require('substitute').line";
          "gS".__raw = "require('substitute').eol";
          "gx".__raw = "require('substitute.exchange').operator";
          "gxx".__raw = "require('substitute.exchange').line";
          "gxc".__raw = "require('substitute.exchange').cancel";
          "gd" = "<cmd>Telescope lsp_definitions<CR>";
          "gr" = "<cmd>Telescope lsp_references<CR>";
          "gi" = "<cmd>Telescope lsp_implementations<CR>";

          "l" = "<C-u>";
          "h" = "<C-d>";
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

          "<leader>h" = ":let @/='\\<'.expand('<cword>').'\\>' | set hlsearch | let v:searchforward=1<CR>";
          "<leader>e".__raw = "vim.diagnostic.open_float";
          "<leader>i".__raw = "vim.lsp.buf.hover";
          "<leader>r".__raw = "vim.lsp.buf.rename";
          "<leader>a".__raw = "vim.lsp.buf.code_action";
          "<leader>t" = "<cmd>b term_root<CR>";
          "<leader>g" = "<cmd>Gedit :<CR>";

          "<leader>cd" = "<cmd>Cd<CR>:te<CR>:f term_root<CR>";
          "<leader>cl" = "<cmd>Clear<CR>";
          "<leader>cm" = "<cmd>ToggleBufMarks<CR>";
          "<leader>ct" = "<cmd>e term://${buffer_path}:h//$SHELL<CR>i";
          "<leader>cr" = "<cmd>Spectre<CR>";

          "<leader>f" = "<cmd>Telescope find_files<CR>";
          "<leader>F" = "<cmd>Telescope find_files cwd=${buffer_path}:h<CR>";
          "<leader>l" = "<cmd>Telescope live_grep<CR>";
          "<leader>L" = "<cmd>Telescope live_grep cwd=${buffer_path}:h<CR>";
          "<leader>b" = "<cmd>Telescope buffers<CR>";
          "<leader>o" = "<cmd>Telescope jumplist<CR>";
          # "<leader>t" = "<cmd>Telescope treesitter<CR>";
          # "<leader>s" = "<cmd>Telescope lsp_document_symbols<CR>";
          "<leader>m" = "<cmd>Telescope marks<CR>";
          "<leader>w" = "<cmd>Telescope lsp_workspace_symbols<CR>";
          "<leader>E" = "<cmd>Telescope diagnostics<CR>";

          "<leader>y" = "\"+y";
          "<leader>Y" = "\"+Y";
          "<leader>p" = "\"+p";
          "<leader>P" = "\"+P";

          # "<leader>mc" = "<cmd>RemoteSSHFSConnect<CR>";
          # "<leader>md" = "<cmd>RemoteSSHFSDisconnect<CR>";
          # "<leader>mf" = "<cmd>RemoteSSHFSFindFiles<CR>";
          # "<leader>ml" = "<cmd>RemoteSSHFSLiveGrep<CR>";

          "<LeftMouse>" = "<LeftMouse><cmd>lua vim.lsp.buf.definition()<CR>";
          "<2-LeftMouse>" = "<LeftMouse><cmd>lua vim.lsp.buf.definition()<CR>";
          "<3-LeftMouse>" = "<LeftMouse><cmd>lua vim.lsp.buf.definition()<CR>";
          "<4-LeftMouse>" = "<LeftMouse><cmd>lua vim.lsp.buf.definition()<CR>";
          "<LeftDrag>" = "<Nop>";
          "<2-LeftDrag>" = "<Nop>";
          "<3-LeftDrag>" = "<Nop>";
          "<4-LeftDrag>" = "<Nop>";
          "<LeftRelease>" = "<Nop>";
          "<2-LeftRelease>" = "<Nop>";
          "<3-LeftRelease>" = "<Nop>";
          "<4-LeftRelease>" = "<Nop>";

          "<RightMouse>" = "<LeftMouse><cmd>lua vim.lsp.buf.hover()<CR>";
          "<2-RightMouse>" = "<LeftMouse><cmd>lua vim.lsp.buf.hover()<CR>";
          "<3-RightMouse>" = "<LeftMouse><cmd>lua vim.lsp.buf.hover()<CR>";
          "<4-RightMouse>" = "<LeftMouse><cmd>lua vim.lsp.buf.hover()<CR>";
          "<RightDrag>" = "<Nop>";
          "<2-RightDrag>" = "<Nop>";
          "<3-RightDrag>" = "<Nop>";
          "<4-RightDrag>" = "<Nop>";
          "<RightRelease>" = "<Nop>";
          "<2-RightRelease>" = "<Nop>";
          "<3-RightRelease>" = "<Nop>";
          "<4-RightRelease>" = "<Nop>";

          "<X1Mouse>" = "<C-o>";
          "<2-X1Mouse>" = "<C-o>";
          "<3-X1Mouse>" = "<C-o>";
          "<4-X1Mouse>" = "<C-o>";

          "<X2Mouse>" = "<C-i>";
          "<2-X2Mouse>" = "<C-i>";
          "<3-X2Mouse>" = "<C-i>";
          "<4-X2Mouse>" = "<C-i>";
        };
      visual =
        lib.mapAttrsToList (key: action: {
          mode = "x";
          inherit key action;
        }) {
          "l" = "<C-u>";
          "h" = "<C-d>";
          "H" = "zL";
          "L" = "zH";
          ">" = ">gv";
          "<" = "<gv";
          "gs".__raw = "require('substitute').visual";
          "s" = "\"_s";

          "p" = "<Plug>(YankyPutAfter)";
          "P" = "<Plug>(YankyPutBefore)";
          "gp" = "<Plug>(YankyGPutAfter)";
          "gP" = "<Plug>(YankyGPutBefore)";
          "gx".__raw = "require('substitute.exchange').visual";

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
          inherit key action;
        }) {
          "<C-Backspace>" = "<C-w>";
          "<C-v>" = "<C-r>" + clipboard;
        };
      terminal =
        lib.mapAttrsToList (key: action: {
          mode = "t";
          inherit key action;
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

      local target_modes = { "n", "v", "o" }

      local function is_target_chord(lhs)
        local first_char = lhs:sub(1, 1)
        return (first_char == "[" or first_char == "]") and #lhs > 1
      end

      -- Use vim.schedule to run this right AFTER all built-in plugins (like matchit) load
      vim.schedule(function()
        for _, mode in ipairs(target_modes) do
          for _, map in ipairs(vim.api.nvim_get_keymap(mode)) do
            if is_target_chord(map.lhs) then
              pcall(vim.keymap.del, mode, map.lhs)
            end
          end
        end
      end)

      -- Keep the buffer-local protection for whenever new files open
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "*",
        callback = function()
          for _, mode in ipairs(target_modes) do
            for _, map in ipairs(vim.api.nvim_buf_get_keymap(0, mode)) do
              if is_target_chord(map.lhs) then
                pcall(vim.keymap.del, mode, map.lhs, { buffer = true })
              end
            end
          end
        end,
      })
    '';
  };
}
