{ pkgs, ... }: {
  environment = {
    systemPackages = with pkgs; [
      jdk23
    ];
  };

  home-manager.users.user = {
    imports = [
      ../../home_modules/btop.nix
    ];
  };
}
