{ pkgs, ... }: {
  programs.nixvim = {
    # extraPlugins = [
    #   (pkgs.vimUtils.buildVimPlugin {
    #     pname = "llm.nvim";
    #     version = "2024-02-22";
    #     src = pkgs.fetchFromGitHub {
    #       owner = "huggingface";
    #       repo = "llm.nvim";
    #       rev = "51b76dac9c33c0122adfe28daf52ceaa31c4aa02";
    #       sha256 = "sha256-fQJA2z9fsd9HU5p9bjHsQfdt/vObNz9pQIz4FVePIR4=";
    #     };
    #     meta.homepage = "https://github.com/huggingface/llm.nvim/";
    #   })
    # ];
    #
    # extraConfigLua = ''
    #   require('llm').setup({
    #     backend = "ollama",
    #     model = "llama3:text",
    #     url = "http://localhost:11434/api/generate",
    #     request_body = {
    #       parameters = {
    #         temperature = 0.2,
    #         top_p = 0.95,
    #       }
    #     },
    #     lsp = {
    #       bin_path = "${pkgs.llm-ls}/bin/llm-ls",
    #     },
    #     enable_suggestions_on_startup = false,
    #   })
    # '';

    # extraPlugins = [
    #   pkgs.vimPlugins.llm-nvim
    # ];
    # extraConfigLua = ''
    #   require('llm').setup({
    #     backend = "ollama",
    #     model = "llama3:text",
    #     url = "http://localhost:11434",
    #     request_body = {
    #       options = {
    #         temperature = 0.2,
    #         top_p = 0.95,
    #       }
    #     },
    #     lsp = {
    #       bin_path = "${pkgs.llm-ls}/bin/llm-ls",
    #     },
    #     enable_suggestions_on_startup = false,
    #   })
    # '';

    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        name = "model.nvim";
        src = pkgs.fetchFromGitHub {
          owner = "gsuuon";
          repo = "model.nvim";
          rev = "c1d15b34c35b565828bc30c44b7741f8f69d4a1c";
          sha256 = "sha256-uZu0WVRF7J1MASG/oVsfc78a8IdoL4lioH2GPn98vfU=";
        };
      })
      pkgs.vimPlugins.term-edit-nvim
      # pkgs.vimPlugins.replacer-nvim
      pkgs.vimPlugins.quickfix-reflector-vim
    ];

    extraConfigLua = ''
      local ollama = require('model.providers.ollama')
      local system = '<|start_header_id|>system<|end_header_id|>\n\n'
      local user = '<|start_header_id|>user<|end_header_id|>\n\n'
      local ai = '<|start_header_id|>assistant<|end_header_id|>\n\n'
      local eot = '<|eot_id|>'

      local spell = 'system: You must correct user spelling. For example "You meant to ask...". Then answer that question.\n'
      require('model').setup({
        prompts = {
          llama3 = {
            provider = ollama,
            params = {
              model = 'llama3'
            },
            builder = function(input)
              return {
                prompt = input
                  :gsub('^spell%s*', spell)
                  :gsub('^system:%s*', system)
                  :gsub('\nme:%s*', '\n' .. eot .. user)
                  :gsub('\nyou:%s*', '\n' .. eot .. ai)
              }
            end
          },
          ['llama3:text'] = {
            provider = ollama,
            params = {
              model = 'llama3:text'
            },
            builder = function(input)
              return {
                prompt = input
              }
            end
          },
        },
      })

      require('term-edit').setup({
        prompt_end = '> ',
      })
    '';
  };
}
