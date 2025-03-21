{
  programs.nixvim = {
    plugins.ollama = {
      enable = true;
      model = "llama3:text";
      url = "http://localhost:11434";
      prompts = {
        Complete = {
          prompt = "$before";
          action = "insert";
          extract = false;
        };
        CompleteDisplay = {
          prompt = "$before";
          action = "display_insert";
          extract = false;
        };
      };
    };
  };
}
