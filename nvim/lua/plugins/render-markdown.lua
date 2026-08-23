return {
  'andrewroxby/render-markdown.nvim',
  branch = 'table-wrap-fixes',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {},
  init = function(opts)
    local rm = require 'render-markdown'
    rm.setup(opts)
    vim.keymap.set('n', '<leader>tm', rm.toggle, { desc = '[T]oggle [M]arkdown rendering' })
  end,
}
