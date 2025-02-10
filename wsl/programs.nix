{ lib, pkgs, ... }: {
  environment = {
    systemPackages = with pkgs; [
      p4
      tmux
    ];
  };

  programs = {
    nixvim = {
      keymaps = let
        normal =
          lib.mapAttrsToList (key: action: {
            mode = "n";
            inherit action key;
          }) {
          };
        visual =
          lib.mapAttrsToList (key: action: {
            mode = "v";
            inherit action key;
          }) {
            "<leader>p" = "\"_dP";
          };
        insert =
          lib.mapAttrsToList (key: action: {
            mode = "!";
            inherit action key;
          }) {
            "<C-v>" = "<C-r>\"";
          };
        terminal =
          lib.mapAttrsToList (key: action: {
            mode = "t";
            inherit action key;
          }) {
            "<C-v>" = "<C-\\><C-o>p";
          };
      in
        (normal ++ visual ++ insert ++ terminal);
    };
  };

  home-manager.users.user = {
    imports = [
      ../shared/btop.nix
    ];
  };
}
