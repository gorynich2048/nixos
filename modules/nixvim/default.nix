{ nixvim, ... }: {
  imports = [
    nixvim.nixosModules.nixvim
    ./autocommands.nix
    ./completion.nix
    ./extras.nix
    ./keymaps.nix
    ./options.nix
    ./theme.nix
    ./plugins
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
  };
}
