{ lib, ... }: {
  programs = {
    nixvim = {
      clipboard.register = "unnamedplus";
      keymaps = let
        normal =
          lib.mapAttrsToList (key: action: {
            mode = "n";
            inherit action key;
          }) {
            "p" = "\"+p";
            "P" = "\"+P";
          };
        visual =
          lib.mapAttrsToList (key: action: {
            mode = "x";
            inherit action key;
          }) {
            "<leader>p" = "\"_d\"+P";
            "p" = "\"+p";
            "P" = "\"+P";
          };
        insert =
          lib.mapAttrsToList (key: action: {
            mode = "!";
            inherit action key;
          }) {
            "<C-v>" = "<C-r>+";
          };
        terminal =
          lib.mapAttrsToList (key: action: {
            mode = "t";
            inherit action key;
          }) {
            "<C-v>" = "<C-\\><C-o>\"+p";
          };
      in
        (normal ++ visual ++ insert ++ terminal);
    };
  };
}
