{ pkgs, ... }: {
  imports = [
    ./nixvim
  ];

  users.users.user = {
    uid = 1000;
    shell = pkgs.fish;
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIANY37jZd9CA4E2ktVrexTOochSow1yE4NYfCUB74fDC gorynich"
    ];
  };

  home-manager.users.user = {
    imports = [
      ../../home_modules/btop.nix
      ../../home_modules/git.nix
    ];
  };
}
