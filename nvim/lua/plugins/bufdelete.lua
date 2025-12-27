-- Delete buffers, keep layout

local function abbrev(before, after)
  local cmd =
    string.format("cabbrev %s <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? '%s' : '%s')<CR>", before, after, before)
  vim.cmd(cmd)
end

return {
  'famiu/bufdelete.nvim',
  cmd = { 'Bdelete', 'Bwipeout' },
  keys = {
    { '<leader>bd', '<cmd>Bdelete<CR>', desc = '[B]uffer [D]elete' },
  },
  init = function()
    abbrev('bd', 'Bdelete')
    abbrev('bd!', 'Bdelete!')
    abbrev('bw', 'Bwipeout')
  end,
}
