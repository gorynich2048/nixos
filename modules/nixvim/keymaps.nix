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
          "\\" = ":Oil<CR>";
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
          # "<C-Up>" = ":resize -2<CR>";
          # "<C-Down>" = ":resize +2<CR>";
          # "<C-Left>" = ":vertical resize +2<CR>";
          # "<C-Right>" = ":vertical resize -2<CR>";

          "<C-Up>" = "<C-w>k";
          "<C-Down>" = "<C-w>j";
          "<C-Left>" = "<C-w>h";
          "<C-Right>" = "<C-w>l";
        };
      visual =
        lib.mapAttrsToList
        (key: action: {
          mode = "v";
          inherit action key;
        })
        {
          # Replace without yank
          "<leader>p" = "\"_dP";

          # Delete without yank
          "<leader>d" = "\"_d";
        };
      insert =
        lib.mapAttrsToList
        (key: action: {
          mode = "i";
          inherit action key;
        })
        {
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
          "<C-Esc>" = "<Esc>";
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
