{ config, ... }: {
  programs.nixvim = {
    globals = {
      loaded_ruby_provider = 0;
      loaded_perl_provider = 0;
      loaded_python3_provider = 0;
      loaded_node_provider = 0;
      terminal_scrollback_buffer_size = 100000;
    };

    clipboard = {
      register = if config.networking.hostName == "local" then "unnamedplus" else "unnamed";
      providers.wl-copy.enable = true;
    };

    opts = {
      updatetime = 100; # Faster completion

      relativenumber = true;
      number = true;
      mouse = "a";
      mousemodel = "popup_setpos";
      splitbelow = true;
      splitright = true;

      swapfile = false;
      ignorecase = true;
      smartcase = true;
      scrolloff = 10;
      signcolumn = "yes";
      laststatus = 3;
      wrap = false;

      # Tab options
      tabstop = 4;
      shiftwidth = 4;
      expandtab = true;

      # Folding
      foldmethod = "expr";
      foldlevel = 99;

      virtualedit = "block";
      shadafile = "NONE";
      jumpoptions = ["stack" "clean"];
      isfname = "@,48-57,/,.,-,_,+,,,#,$,%,~,=,!";
    };
  };
}
