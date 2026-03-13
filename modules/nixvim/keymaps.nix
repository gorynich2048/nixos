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
      operator = 
        lib.mapAttrsToList (key: action: {
          mode = "";
          inherit action key;
        }) {
        };
      path_match = "%:s?term:.*??:s?oil://??:p:h";
      normal =
        lib.mapAttrsToList (key: action: {
          mode = "n";
          inherit action key;
        }) {
          "<Backspace>" = ":Oil<CR>";
          "gw" = ":Oil .<CR>";
          "gh" = ":Oil ~/.home/<CR>";
          "gt" = ":b term_root<CR>";
          "yp" = ":let @+=@%<CR>";
          "gs" = ":G<CR>:only<CR>";
          "gl" = ":G l<CR>:only<CR>";
          "<leader>t" = ":e term://${path_match}//$SHELL<CR>i";
          "<leader>e" = ":lua vim.diagnostic.open_float()<CR>";
          "<leader>s" = ":Spectre<CR>";

          "<leader>f" = ":Telescope find_files<CR>";
          "<leader>F" = ":Telescope find_files cwd=${path_match}<CR>";
          "<leader>l" = ":Telescope live_grep<CR>";
          "<leader>L" = ":Telescope live_grep cwd=${path_match}<CR>";
          "<leader>b" = ":Telescope buffers<CR>";
          "<leader>cd" = ":Cd<CR>:te<CR>:f term_root<CR>";

          "<Space>" = "<NOP>";
          "<Esc>" = ":noh<CR>";

          "<C-d>" = "M<C-d>zz";
          "<C-u>" = "M<C-u>";
          # "<C-o>" = "<C-o>zzzv";
          "n" = "nzzzv";
          "N" = "Nzzzv";
          "zz" = "zzzszH";
          "<C-i>" = "<C-i>zz";

          # "<S-Up>" = ":resize +2<CR>";
          # "<S-Down>" = ":resize -2<CR>";
          # "<S-Left>" = ":vertical resize -2<CR>";
          # "<S-Right>" = ":vertical resize +2<CR>";
          "<S-Up>" = "5<Up>";
          "<S-Down>" = "5<Down>";
          "<S-Left>" = "5<Left>";
          "<S-Right>" = "5<Right>";

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

          "<C-s>" = ":w<CR>";
          "<C-S>" = ":wa<CR>";

          "[<Space>" = "O<Esc>";
          "]<Space>" = "o<Esc>";
        };
      visual =
        lib.mapAttrsToList (key: action: {
          mode = "x";
          inherit action key;
        }) {
          "<leader>d" = "\"_d";

          "l" = "<C-u>";
          "h" = "<C-d>";

          "<leader>a".__raw = "vim.lsp.buf.code_action";
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
