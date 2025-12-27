-- File manager
return {
  'mikavilpas/yazi.nvim',
  version = "*",
  event = "VeryLazy",
  dependencies = {
    { 'nvim-lua/plenary.nvim', lazy = true },
  },
  keys = {
    { '<leader>oy', '<cmd>Yazi<CR>', desc = '[Y]azi (at current file)' },
    { '<leader>oY', '<cmd>Yazi cwd<CR>', desc = '[Y]azi (at cwd)' },
  },
  opts = {
    open_for_directories = true,
  },
  init = function()
    -- Don't load netrw, we're using Yazi instead
    -- https://github.com/mikavilpas/yazi.nvim/issues/802
    vim.g.loaded_netrwPlugin = 1
  end,
}
