-- File manager
return {
  'mikavilpas/yazi.nvim',
  version = '*',
  event = 'VeryLazy',
  dependencies = {
    { 'nvim-lua/plenary.nvim', lazy = true },
  },
  keys = {
    { '<leader>ff', '<cmd>Yazi<CR>', desc = 'Open Yazi (at current file)' },
    { '<leader>fF', '<cmd>Yazi cwd<CR>', desc = 'Open Yazi (at cwd)' },
  },
  opts = {
    open_for_directories = true,
    hooks = {
      yazi_opened = function(_, buf, _)
        vim.keymap.set('t', '<Esc>', '<C-c>', { buffer = buf, nowait = true })
      end,
    },
  },
  init = function()
    -- Don't load netrw, we're using Yazi instead
    -- https://github.com/mikavilpas/yazi.nvim/issues/802
    vim.g.loaded_netrwPlugin = 1
  end,
}
