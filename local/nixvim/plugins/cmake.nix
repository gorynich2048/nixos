{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    cmake
    gcc_multi
    ninja
  ];
  programs.nixvim = {
    plugins = {
      cmake-tools.enable = true;
    };
  };
}
