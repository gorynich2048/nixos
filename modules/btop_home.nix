{ pkgs, ... }: {
  programs.btop = {
    enable = true;
    package = pkgs.btop-cuda;
    settings = {
      rounded_corners = false;
      theme_background = false;
      show_coretemp = false; # broken
      cpu_graph_upper = "user";
      cpu_graph_lower = "system";
      shown_boxes = "cpu mem net proc gpu0";
      update_ms = 100;
    };
  };
}
