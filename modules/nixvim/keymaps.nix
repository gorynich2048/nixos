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
          "<Backspace>" = ":Oil<CR>";
          "<C-Backspace>" = ":Oil .refs/<CR>";
          "<leader>t" = ":e term://%:s?term:.*??:s?oil://??:p:h//$SHELL<CR>i";
          "<leader>k" = ":lua vim.diagnostic.open_float()<CR>";
          "<leader>s" = ":lua require('spectre').toggle()<CR>";
          "<leader>ff" = ":FzfLua files<CR>";
          "<leader>fl" = ":FzfLua live_grep<CR>";
          "<leader>b" = ":FzfLua buffers<CR>";

          "<Space>" = "<NOP>";

          # Esc to clear search results
          "<esc>" = ":noh<CR>";

          # Center view
          "<C-d>" = "M<C-d>zz";
          "<C-u>" = "M<C-u>";
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
          mode = "!";
          inherit action key;
        })
        {
          "<C-v>" = "<C-r>+";
          "<C-Backspace>" = "<C-w>";
        };
      terminal =
        lib.mapAttrsToList
        (key: action: {
          mode = "t";
          inherit action key;
        })
        {
          "<C-v>" = "<C-\\><C-o>\"+p";
          "<C-Backspace>" = "<C-w>";

          # Propagate esc in terminal mode
          "<Esc>" = "<C-\\><C-n>";
          "<C-i>" = "<C-\\><C-n><C-i>";
          "<C-o>" = "<C-\\><C-n><C-o>";
          "<C-Esc>" = "<Esc>";
          "<Tab>" = "<Tab>";
        };
    in
      (normal ++ visual ++ insert ++ terminal);
  };
}
