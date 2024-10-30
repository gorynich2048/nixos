{ pkgs, ... }: {
  environment = {
    systemPackages = with pkgs; [
      himalaya
    ];
  };
  programs.nixvim = {
    extraPlugins = [
      pkgs.vimPlugins.himalaya-vim
    ];
  };
}
