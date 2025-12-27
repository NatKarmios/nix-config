-- Buffer-wise Git utilities
return {
  'lewis6991/gitsigns.nvim',
  lazy = false,
  keys = {
    { mode = { 'n', 'x', 'o' }, '[c', '<cmd>Gitsigns nav_hunk prev<CR>', desc = 'Previous Git change' },
    { mode = { 'n', 'x', 'o' }, ']c', '<cmd>Gitsigns nav_hunk next<CR>', desc = 'Next Git change' },
    { mode = { 'n', 'v' }, '<leader>gS', '<cmd>Gitsigns reset_hunk<CR>', desc = 'Un[S]tage hunk' },
    { mode = { 'n', 'v' }, '<leader>gs', '<cmd>Gitsigns stage_hunk<CR>', desc = '[S]tage hunk' },
    { '<leader>gh', '<cmd>Gitsigns preview_hunk<CR>', desc = 'Preview [H]unk' },
  },
}
