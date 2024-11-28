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
      local parse = function(input, system, user, assistant)
        return {
          prompt = system .. input
            :gsub('\n# %s*me%s*\n', user)
            :gsub('\n# %s*you%s*\n', assistant)
        }
      end

      require('model').setup({
        prompts = {
          llama3 = {
            provider = ollama, params = {
              model = 'llama3',
              raw = true
            },
            builder = function(input)
              return parse(input,
                '<|start_header_id|>system<|end_header_id|>\n\n',
                '<|eot_id|><|start_header_id|>user<|end_header_id|>\n\n',
                '<|eot_id|><|start_header_id|>assistant<|end_header_id|>\n\n'
              )
            end
          },
          ['llama3:text'] = {
            provider = ollama, params = {
              model = 'llama3:text',
              raw = true
            },
            builder = function(input)
              return {
                prompt = input
              }
            end
          },
          ['qwen2.5-coder:32b'] = {
            provider = ollama, params = {
              model = 'qwen2.5-coder:32b',
              raw = true,
              options = {
                num_ctx = 32768,
                temperature = 0
              }
            },
            builder = function(input)
              return parse(input,
                '<|im_start|>system\n',
                '<|im_end|>\n<|im_start|>user\n',
                '<|im_end|>\n<|im_start|>assistant\n'
              )
            end
          },
          ['hf.co/mradermacher/MN-12B-Siskin-v0.1-i1-GGUF:Q4_K_M'] = {
            provider = ollama, params = {
              model = 'hf.co/mradermacher/MN-12B-Siskin-v0.1-i1-GGUF:Q4_K_M',
              raw = true,
              options = {
                num_ctx = 32768
              }
            },
            builder = function(input)
              return parse(input,
                "",
                '</s>[INST] ',
                '[/INST]  '
              )
            end
          },
        },
      })

      require('term-edit').setup({
        prompt_end = '> ',
        default_reg = '+'
      })
    '';
  };
}
