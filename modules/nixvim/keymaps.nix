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
      buffer_path = "%:s?term:.*??:s?oil://??:p";
      normal =
        lib.mapAttrsToList (key: action: {
          mode = "n";
          inherit action key;
        }) {
          "<C-s>" = ":w<CR>";
          "<Backspace>" = ":Oil<CR>";
          "gw" = ":Oil .<CR>";
          "gh" = ":Oil ~/!/<CR>";
          "gt" = ":b term_root<CR>";
          "yp" = ":let @+=expand(\"${buffer_path}\")<CR>";
          "gs" = ":G<CR>:only<CR>";
          "gl" = ":G l<CR>:only<CR>";

          "<leader>t" = ":e term://${buffer_path}:h//$SHELL<CR>i";
          "<leader>e" = ":lua vim.diagnostic.open_float()<CR>";
          "<leader>s" = ":Spectre<CR>";
          "<leader>O" = "O<Esc>";
          "<leader>o" = "o<Esc>";
          "<leader>cd" = ":Cd<CR>:te<CR>:f term_root<CR>";

          "<leader>f" = ":Telescope find_files<CR>";
          "<leader>F" = ":Telescope find_files cwd=${buffer_path}:h<CR>";
          "<leader>l" = ":Telescope live_grep<CR>";
          "<leader>L" = ":Telescope live_grep cwd=${buffer_path}:h<CR>";
          "<leader>b" = ":Telescope buffers<CR>";
          "<leader>y" = "\"+y";
          "<leader>Y" = "\"+Y";

          "<Space>" = "<NOP>";
          "<Esc>" = ":noh<CR>";

          "n" = "nzzzv";
          "N" = "Nzzzv";
          "zz" = "zzzszH";
          "<C-i>" = "<C-i>zz";
          "gf" = "gFzz";
          "gd" = "gdzzzv";

          "<S-Up>" = ":m .-2<CR>==";
          "<S-Down>" = ":m .+1<CR>==";
          "k" = ".";
          "\\" = "/\\V<C-r>\"<CR>";
          "<C-n>" = "o<ESC>";
          "<C-u>" = "O<ESC>";
          "<C-j>" = ":t.<CR>";
          "<C-k>" = "\"_dd";
          "<C-d>" = "\"_dd";

          "l" = "M<C-u>";
          "h" = "M<C-d>zz";
          "H" = "<C-w>w";
          "L" = "<C-w>W";
          "<C-h>" = "<C-w>w";
          "<C-l>" = "<C-w>W";
          "<C-c>" = "<C-w>c";
        };
      visual =
        lib.mapAttrsToList (key: action: {
          mode = "x";
          inherit action key;
        }) {
          # "<leader>d" = "\"_d"; # used by debugger mode
          "<leader>y" = "\"+y";
          "<leader>s" = ":sort<CR>";

          "l" = "M<C-u>";
          "h" = "M<C-d>zz";
          "<S-Up>" = ":m '<-2<CR>gv=gv";
          "<S-Down>" = ":m '>+1<CR>gv=gv";

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
