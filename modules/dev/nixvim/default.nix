{ nixvim, ... }: {
  imports = [
    nixvim.nixosModules.nixvim
    ./plugins
    ./autocommands.nix
    ./extras.nix
    ./keymaps.nix
    ./options.nix
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
  };
}
