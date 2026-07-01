{ config, pkgs, ... }: {
  programs.nixvim = {
    extraPlugins = [
      (pkgs.vimPlugins.term-edit-nvim.overrideAttrs (old: {
        patches = (old.patches or []) ++ [ ./term-edit.patch ];
      }))
      pkgs.vimPlugins.remote-sshfs-nvim
    ];

    extraConfigLua = ''
      require('term-edit').setup({
        prompt_end = '> ',
        default_reg = ${if config.networking.hostName == "local" then "'+'" else "'\"'"}
      })

      require('remote-sshfs').setup()
    '';
  };
}
