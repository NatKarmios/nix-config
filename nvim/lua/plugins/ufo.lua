-- Better folding

function ufoCustomiseSelector(bufnr)
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

return {
  {
    'kevinhwang91/nvim-ufo',
    lazy = false,
    dependencies = {
      { 'kevinhwang91/promise-async' },
    },
    keys = {
      {
        'zR',
        function()
          require('ufo').openAllFolds()
        end,
        desc = 'Open all folds (UFO)',
      },
      {
        'zM',
        function()
          require('ufo').closeAllFolds()
        end,
        desc = 'Close all folds (UFO)',
      },
    },
    config = function()
      vim.o.foldcolumn = '1'
      vim.o.fillchars = 'eob: ,fold: ,foldopen:,foldsep: ,foldclose:'
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      vim.o.numberwidth = 1
      require('ufo').setup({
        provider_selector = function(_, _, _)
          return ufoCustomiseSelector
        end,
      })
    end,
  },

  -- Hide fold level number in status column
  {
    'luukvbaal/statuscol.nvim',
    lazy = false,
    config = function()
      local builtin = require('statuscol.builtin')
      require('statuscol').setup({
        segments = {
          { text = { '%s' }, click = 'v:lua.ScSa' },
          { text = { builtin.lnumfunc }, click = 'v:lua.ScLa', },
          {
            text = { ' ', builtin.foldfunc, ' ' },
            condition = { builtin.not_empty, true, builtin.not_empty },
            click = 'v:lua.ScFa'
          },
        },
      })
    end,
  },
}
