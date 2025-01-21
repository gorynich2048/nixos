{ ... }: {
  imports = [
    ./programs.nix
    ./services.nix
    ../shared
    <nixos-wsl/modules>
  ];

  wsl = {
    enable = true;
    defaultUser = "user";
  };

  networking = {
    hostName = "wsl";
    extraHosts = ''
      128.140.88.66 h
    '';
  };
}
