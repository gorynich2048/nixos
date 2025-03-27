{
  programs.btop = {
    enable = true;
    settings = {
      rounded_corners = false;
      theme_background = false;
      show_gpu_info = "On";
      show_coretemp = false;
      cpu_graph_upper = "user";
      cpu_graph_lower = "system";
      update_ms = 100;
    };
  };
}
