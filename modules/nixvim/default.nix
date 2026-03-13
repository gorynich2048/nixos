{ nixvim, ... }: {
  imports = [
    nixvim.nixosModules.nixvim
    ./autocommands.nix
    ./completion.nix
    ./extras.nix
    ./keymaps.nix
    ./options.nix
    ./plugins
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
  };
}
