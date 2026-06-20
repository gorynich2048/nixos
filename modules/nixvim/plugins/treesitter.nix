{
  programs.nixvim = {
    plugins = {
      treesitter = {
        enable = true;

        # Highlight Lua and VimScript inside nix expressions
        nixvimInjections = true;

        highlight.enable = true;
        folding.enable = true;
        indent.enable = false;
      };

      # Highlight Bash inside nix expressions
      # broken
      # hmts.enable = true;
    };

    # extraFiles."after/queries/rust/highlights.scm".text = ''
    #   ;; extends
    #   (assignment_expression "=" @my_important (#set! "priority" 130))
    #   (compound_assignment_expr [
    #     "+=" "-=" "*=" "/=" "%=" "<<=" ">>=" "&=" "^=" "|="
    #   ] @my_important (#set! "priority" 130))
    #
    #   (parameter type: (reference_type "&" @my_important) (#set! "priority" 130))
    #   (parameter type: (pointer_type "*" @my_important) (#set! "priority" 130))
    #   (self_parameter "&" @my_important (#set! "priority" 130))
    #   (function_item return_type: (reference_type "&" @my_important) (#set! "priority" 130))
    #   (function_item return_type: (pointer_type "*" @my_important) (#set! "priority" 130))
    #
    #   (try_expression "?" @my_important (#set! "priority" 130))
    # '';
  };
}
