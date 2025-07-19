# Better folding
{ lib, ... }:
with lib.custom.nixvim;
{
  programs.nixvim = {
    plugins.nvim-ufo = {
      enable = true;
      setupLspCapabilities = true;

      # lsp -> treesitter -> indent
      luaConfig.pre = ''
        ---@param bufnr number
        ---@return Promise
        local function ufoCustomiseSelector(bufnr)
            local function handleFallbackException(err, providerName)
                if type(err) == 'string' and err:match('UfoFallbackException') then
                    return require('ufo').getFolds(bufnr, providerName)
                else
                    return require('promise').reject(err)
                end
            end

            return require('ufo').getFolds(bufnr, 'lsp'):catch(function(err)
                return handleFallbackException(err, 'treesitter')
            end):catch(function(err)
                return handleFallbackException(err, 'indent')
            end)
        end
      '';

      settings.provider_selector = ''
        function(_, _, _)
          return ufoCustomiseSelector
        end
      '';
    };

    opts = {
      # Copied from `nvim-ufo` README
      foldcolumn = "1";
      fillchars = "eob: ,fold: ,foldopen:,foldsep: ,foldclose:";
      foldlevel = 99;
      foldlevelstart = 99;
      foldenable = true;
      numberwidth = 1;
    };

    keymaps = with bind-helpers; lib.flatten [
      (n' "zR" (call "ufo" "openAllFolds()") "Open all folds (UFO)")
      (n' "zM" (call "ufo" "closeAllFolds()") "Close all folds (UFO)")
    ];

    # Hide fold level number in status column
    # https://github.com/neovim/neovim/pull/17446#issuecomment-1407651883
    plugins.statuscol = {
      enable = true;
      luaConfig.pre = ''
        local builtin = require("statuscol.builtin")
      '';
      settings.segments = [
        { text = ["%s"]; click = "v:lua.ScSa"; }
        { text = [(raw "builtin.lnumfunc")]; click = "v:lua.ScLa"; }
        {
          text = [ " " (raw "builtin.foldfunc") " " ];
          condition = [ (raw "builtin.not_empty") true (raw "builtin.not_empty")];
          click = "v:lua.ScFa";
        }
      ];
    };

    # The fold column was cyan for some reason??
    # Just set it to be the same as line numbers
    extraConfigLuaPost = ''
      vim.api.nvim_set_hl(0, "FoldColumn", vim.api.nvim_get_hl(0, {}).LineNr)
    '';
  };
}
