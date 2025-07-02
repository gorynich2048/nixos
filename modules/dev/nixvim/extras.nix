{ pkgs, ... }: {
  programs.nixvim = {
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
    ];

    extraConfigLua = ''
      vim.g.wordmotion_uppercase_spaces = {
        '!','/','(',')','|','=',':','.','&','-','[',']','~',
        '"','{','}','*',"'",',',';','%','?','`','<','>','+',
        '#','@','\\','^','$'
      }

      local ollama = require('model.providers.ollama')
      local parse = function(input, system, user, assistant)
        return {
          prompt = system .. input
            :gsub('\n# me[%s=]*\n', user)
            :gsub('\n# ai[%s=]*\n', assistant)
            :gsub('\n# you[%s=]*\n', assistant)
            :gsub('^# me[%s=]*\n', user)
            :gsub('^# ai[%s=]*\n', assistant)
            :gsub('^# you[%s=]*\n', assistant)
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
                num_ctx = 4096,
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
          ['hf.co/mradermacher/MN-12B-Siskin-v0.1-i1-GGUF'] = {
            provider = ollama, params = {
              model = 'hf.co/mradermacher/MN-12B-Siskin-v0.1-i1-GGUF:IQ3_S',
              raw = true,
              options = {
                num_ctx = 2048
              }
            },
            builder = function(input)
              return parse(input,
                "",
                '</s><s>[INST] ',
                ' [/INST] '
              )
            end
          },
          ['deepseek-r1:14b'] = {
            provider = ollama, params = {
              model = 'deepseek-r1:14b',
              raw = true,
              options = {
                num_ctx = 2048,
              }
            },
            builder = function(input)
              return parse(input,
                "",
                '<｜end▁of▁sentence｜><｜User｜>',
                '<｜Assistant｜>'
              )
            end
          },
          ['deepseek-r1:7b'] = {
            provider = ollama, params = {
              model = 'deepseek-r1:7b',
              raw = true,
              options = {
                num_ctx = 2048,
              }
            },
            builder = function(input)
              return parse(input,
                "",
                '<｜end▁of▁sentence｜><｜User｜>',
                '<｜Assistant｜>'
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
