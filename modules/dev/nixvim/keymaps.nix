{ lib, ... }: {
  programs.nixvim = {
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    userCommands = {
      Cd.command = ":lua require(\"oil.actions\").cd.callback()<CR>";
    };

    keymaps = let
      # :h map-modes
      normal =
        lib.mapAttrsToList (key: action: {
          mode = "n";
          inherit action key;
        }) {
          "<Backspace>" = ":Oil<CR>";
          "<C-Backspace>" = ":Oil .<CR>";
          "<S-Tab>" = ":Oil ~/.refs/<CR>";
          "<leader>t" = ":e term://%:s?term:.*??:s?oil://??:p:h//$SHELL<CR>i";
          "<leader>h" = ":lua vim.diagnostic.open_float()<CR>";
          "<leader>s" = ":lua require('spectre').toggle()<CR>";

          "<leader>ff" = ":Telescope find_files<CR>";
          "<leader>fl" = ":Telescope live_grep<CR>";
          "<leader>b" = ":Telescope buffers<CR>";
          "<leader>fd" = ":Telescope diagnostics<CR>";

          "<Space>" = "<NOP>";
          "<esc>" = ":noh<CR>";

          "<C-d>" = "M<C-d>zz";
          "<C-u>" = "M<C-u>";
          # "<C-o>" = "<C-o>zzzv";
          "n" = "nzzzv";
          "N" = "Nzzzv";

          "<S-Up>" = ":resize +2<CR>";
          "<S-Down>" = ":resize -2<CR>";
          "<S-Left>" = ":vertical resize -2<CR>";
          "<S-Right>" = ":vertical resize +2<CR>";

          "<C-Up>" = "<C-w>k";
          "<C-Down>" = "<C-w>j";
          "<C-Left>" = "<C-w>h";
          "<C-Right>" = "<C-w>l";

          "l" = "<C-u>";
          "h" = "<C-d>";
          "L" = ":tabp<CR>";
          "H" = ":tabn<CR>";

          "gf" = "gFzzzv";
          "gd" = "gdzzzv";
        };
      visual =
        lib.mapAttrsToList (key: action: {
          mode = "x";
          inherit action key;
        }) {
          "<leader>d" = "\"_d";

          "l" = "<C-u>";
          "h" = "<C-d>";
        };
      insert =
        lib.mapAttrsToList (key: action: {
          mode = "!";
          inherit action key;
        }) {
          "<C-Backspace>" = "<C-w>";
        };
      terminal =
        lib.mapAttrsToList (key: action: {
          mode = "t";
          inherit action key;
        }) {
          "<C-Backspace>" = "<C-w>";

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
