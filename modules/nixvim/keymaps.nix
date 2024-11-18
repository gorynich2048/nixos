{ lib, ... }: {
  programs.nixvim = {
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    keymaps = let
      normal =
        lib.mapAttrsToList
        (key: action: {
          mode = "n";
          inherit action key;
        })
        {
          "<C-Enter>" = ":Oil<CR>";
          "<S-Enter>" = ":Oil .<CR>";
          "<Backspace>" = ":Oil .<CR>";
          "<leader>t" = ":e term://%:s?term:.*??:s?oil://??:p:h//$SHELL<CR>i";
          "<leader>k" = ":lua vim.diagnostic.open_float()<CR>";
          "<leader>s" = ":lua require('spectre').toggle()<CR>";

          "<Space>" = "<NOP>";

          # Esc to clear search results
          "<esc>" = ":noh<CR>";

          # Center view
          "<C-d>" = "<C-d>zz";
          "<C-u>" = "<C-u>zz";
          "n" = "nzzzv";
          "N" = "Nzzzv";

          # TODO: conflicts with diagnostics
          #"<leader>d" = "\"_d";

          "<leader>db" = ":DapToggleBreakpoint<CR>";
          "<leader>dr" = ":DapToggleRepl<CR>";
          "<leader>dt" = ":DapTerminate<CR>";
          "<leader>dc" = ":DapContinue<CR>";
          "<leader>di" = ":DapStepInto<CR>";
          "<leader>do" = ":DapStepOut<CR>";
          "<leader>dn" = ":DapStepOver<CR>";
          "<leader>dd" = ":DapDisconnect<CR>";

          # Resize with arrows
          "<S-Up>" = ":resize +2<CR>";
          "<S-Down>" = ":resize -2<CR>";
          "<S-Left>" = ":vertical resize -2<CR>";
          "<S-Right>" = ":vertical resize +2<CR>";

          "<C-Up>" = "<C-w>k";
          "<C-Down>" = "<C-w>j";
          "<C-Left>" = "<C-w>h";
          "<C-Right>" = "<C-w>l";

          "p" = "\"+p";
          "P" = "\"+P";
        };
      visual =
        lib.mapAttrsToList
        (key: action: {
          mode = "v";
          inherit action key;
        })
        {
          # Replace without yank
          "<leader>p" = "\"_d\"+P";

          # Delete without yank
          "<leader>d" = "\"_d";

          "p" = "\"+p";
          "P" = "\"+P";
        };
      insert =
        lib.mapAttrsToList
        (key: action: {
          mode = "i";
          inherit action key;
        })
        {
          "<C-v>" = "<C-r>+";
        };
      terminal =
        lib.mapAttrsToList
        (key: action: {
          mode = "t";
          inherit action key;
        })
        {
          # Propagate esc in terminal mode
          "<Esc>" = "<C-\\><C-n>";
          "<C-i>" = "<C-\\><C-n><C-i>";
          "<C-o>" = "<C-\\><C-n><C-o>";
          "<C-Esc>" = "<Esc>";
          "<Tab>" = "<Tab>";
        };
    in
      (normal ++ visual ++ insert ++ terminal);

    extraConfigLua = ''
      -- Use lowercase for global marks and uppercase for local marks.
      local low = function(i) return string.char(97+i) end
      local upp = function(i) return string.char(65+i) end

      for i=0,25 do vim.keymap.set("n", "m"..low(i), "m"..upp(i)) end
      for i=0,25 do vim.keymap.set("n", "m"..upp(i), "m"..low(i)) end
      for i=0,25 do vim.keymap.set("n", "'"..low(i), "'"..upp(i)) end
      for i=0,25 do vim.keymap.set("n", "'"..upp(i), "'"..low(i)) end
    '';
  };
}
