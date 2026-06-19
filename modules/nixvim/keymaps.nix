{ lib, config, ... }: {
  programs.nixvim = {
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    userCommands = {
      Cd.command.__raw = "require('oil.actions').cd.callback";
    };

    keymaps = let
      # :h map-modes
      operator = 
        lib.mapAttrsToList (key: action: {
          mode = "";
          inherit action key;
        }) {
        };
      buffer_path = "%:s?term:.*??:s?oil://??:p";
      normal =
        lib.mapAttrsToList (key: action: {
          mode = "n";
          inherit action key;
        }) {
          "<C-s>" = ":w<CR>";
          "<Backspace>" = ":Oil<CR>";
          "H" = "zH";
          "L" = "zL";
          "k" = ".";
          "\\" = "/\\V<C-r>\"<CR>";
          "yp" = ":let @+=expand(\"${buffer_path}\")<CR>";
          "s".__raw = "require('substitute').operator";
          "ss".__raw = "require('substitute').line";
          "S".__raw = "require('substitute').eol";

          "gw" = ":Oil .<CR>";
          "gh" = ":Oil ~/!/<CR>";
          "gt" = ":b term_root<CR>";
          "gs" = ":G<CR>:only<CR>";
          "gl" = ":G l<CR>:only<CR>";
          "gf" = "gFzz";
          "gd" = "gdzz";

          # "n" = "nzz";
          # "N" = "Nzz";
          # "<C-i>" = "<C-i>zz";
          "l" = "M<C-u>";
          "h" = "M<C-d>zz";
          "p" = "<Plug>(YankyPutAfter)";
          "P" = "<Plug>(YankyPutBefore)";
          "gp" = "<Plug>(YankyGPutAfter)";
          "gP" = "<Plug>(YankyGPutBefore)";

          "<Space>" = "<NOP>";
          "<Esc>" = ":noh<CR>";

          "<C-p>" = "<Plug>(YankyPutIndentAfterLinewise)";
          "<C-n>" = "o<ESC>";
          "<C-u>" = "O<ESC>";
          "<C-j>" = ":t.<CR>";
          "<C-d>" = "\"_dd";
          "<C-h>" = "<C-w>w";
          "<C-l>" = "<C-w>W";
          "<C-c>" = "<C-w>c";

          "<C-Up>" = "<Plug>(YankyPreviousEntry)";
          "<C-Down>" = "<Plug>(YankyNextEntry)";

          "<S-Up>" = ":m .-2<CR>==";
          "<S-Down>" = ":m .+1<CR>==";

          "<leader>t" = ":e term://${buffer_path}:h//$SHELL<CR>i";
          "<leader>e".__raw = "vim.diagnostic.open_float";
          "<leader>s" = ":Spectre<CR>";
          "<leader>cd" = ":Cd<CR>:te<CR>:f term_root<CR>";

          "<leader>f" = ":Telescope find_files<CR>";
          "<leader>F" = ":Telescope find_files cwd=${buffer_path}:h<CR>";
          "<leader>l" = ":Telescope live_grep<CR>";
          "<leader>L" = ":Telescope live_grep cwd=${buffer_path}:h<CR>";
          "<leader>b" = ":Telescope buffers<CR>";

          "<leader>y" = "\"+y";
          "<leader>Y" = "\"+Y";
          "<leader>p" = "\"+p";
          "<leader>P" = "\"+P";

          "<leader>mc" = ":RemoteSSHFSConnect<CR>";
          "<leader>md" = ":RemoteSSHFSDisconnect<CR>";
          "<leader>mf" = ":RemoteSSHFSFindFiles<CR>";
          "<leader>ml" = ":RemoteSSHFSLiveGrep<CR>";
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

          "<C-d>" = "\"_d";
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
      (operator ++ normal ++ visual ++ insert ++ terminal);

    extraConfigLua = ''
      -- Use lowercase for global marks and uppercase for local marks.
      local low = function(i) return string.char(97+i) end
      local upp = function(i) return string.char(65+i) end

      for i=0,25 do vim.keymap.set("n", "m"..low(i), "`"..upp(i)) end
      for i=0,25 do vim.keymap.set("n", "M"..low(i), "m"..upp(i)) end
    '';
  };
}
