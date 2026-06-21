{ config, pkgs, ... }: {
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
      pkgs.vimPlugins.remote-sshfs-nvim
    ];

    extraConfigLua = ''
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
        default_reg = ${if config.networking.hostName == "local" then "'+'" else "'\"'"}
      })
      local coord = require('term-edit.coord')
      local async = require('term-edit.async')
      require('term-edit.navigate').navigate_normal = function(target)
        local function n(old)
          local current = coord.get_coord '.'
          if coord.equals(current, old) then
            return
          end
          local keys = nil
          if current.line < target.line then
            keys = string.rep('<Down>', target.line - current.line)
          elseif current.line > target.line then
            keys = string.rep('<Up>', current.line - target.line)
          elseif current.col < target.col then
            keys = string.rep('<Right>', target.col - current.col)
          elseif current.col > target.col then
            keys = string.rep('<Left>', current.col - target.col)
          end
          if keys then
            async.feedkeys(keys, function()
              n(current)
            end, { moves = true, start_normal = true, callback_normal = true })
          end
        end
        n()
      end

      require('remote-sshfs').setup()
    '';
  };
}
