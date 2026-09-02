-- Buffer-wise Git utilities

local if_in_diff = function(in_diff, not_in_diff)
  return function()
    if vim.wo.diff then
      return in_diff
    else
      return not_in_diff
    end
  end
end

return {
  'lewis6991/gitsigns.nvim',
  lazy = false,
  keys = {
    {
      mode = { 'n', 'x', 'o' },
      '[c',
      if_in_diff('[c', '<cmd>Gitsigns nav_hunk prev<CR>'),
      expr = true,
      replace_keycodes = true,
      desc = 'Previous change',
    },
    {
      mode = { 'n', 'x', 'o' },
      ']c',
      if_in_diff(']c', '<cmd>Gitsigns nav_hunk next<CR>'),
      expr = true,
      replace_keycodes = true,
      desc = 'Next change',
    },
    { '<leader>gh', '<cmd>Gitsigns preview_hunk<CR>', desc = 'Preview [H]unk' },
    { mode = { 'n', 'v' }, '<leader>gr', '<cmd>Gitsigns reset_hunk<CR>', desc = '[R]eset hunk' },
    { mode = { 'n', 'v' }, '<leader>g ', '<cmd>Gitsigns stage_hunk<CR>', desc = 'Toggle [S]tage hunk' },
  },
}
