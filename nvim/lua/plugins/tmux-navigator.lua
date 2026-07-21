-- Seamless nagivation between tmux panes and vim splits
return {
  'alexghergh/nvim-tmux-navigation',
  config = function()
    local nvim_tmux_nav = require 'nvim-tmux-navigation'
    local modes = { 'n', 'v', 'i', 't' }
    vim.keymap.set(modes, '<C-h>', nvim_tmux_nav.NvimTmuxNavigateLeft)
    vim.keymap.set(modes, '<C-j>', nvim_tmux_nav.NvimTmuxNavigateDown)
    vim.keymap.set(modes, '<C-k>', nvim_tmux_nav.NvimTmuxNavigateUp)
    vim.keymap.set(modes, '<C-l>', nvim_tmux_nav.NvimTmuxNavigateRight)
  end,
}
