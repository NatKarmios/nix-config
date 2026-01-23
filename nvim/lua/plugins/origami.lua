-- Better folding
return {
  {
    'chrisgrieser/nvim-origami',
    event = 'VeryLazy',
    opts = {},

    init = function()
      vim.o.foldcolumn = '1'
      vim.o.fillchars = 'eob: ,fold: ,foldopen:,foldsep: ,foldclose:'
      vim.opt.foldlevel = 99
      vim.opt.foldlevelstart = 99
      vim.o.foldenable = true
      vim.o.numberwidth = 1
    end,
  },

  -- Show fold icon (nicely) in status column
  {
    'luukvbaal/statuscol.nvim',
    lazy = false,
    config = function()
      local builtin = require 'statuscol.builtin'
      require('statuscol').setup {
        segments = {
          { text = { '%s' }, click = 'v:lua.ScSa' },
          { text = { builtin.lnumfunc }, click = 'v:lua.ScLa' },
          {
            text = { ' ', builtin.foldfunc, ' ' },
            condition = { builtin.not_empty, true, builtin.not_empty },
            click = 'v:lua.ScFa',
          },
        },
      }
    end,
  },
}
