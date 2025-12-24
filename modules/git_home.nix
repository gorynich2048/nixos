{
  programs.git = {
    enable = true;
    settings = {
      alias = {
        l = "log --all --decorate --oneline --graph";
      };
      user = {
        name = "gorynich";
        email = "terr2048@gmail.com";
      };
    };
  };
}
