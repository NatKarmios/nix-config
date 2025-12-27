-- LSP previews
return {
  'DNLHC/glance.nvim',
  cmd = 'Glance',
  opts = {
    list = {
      position = 'left',
    },
  },
  init = function()
    vim.keymap.del('n', 'grn')
    vim.keymap.del('n', 'grr')
    vim.keymap.del({ 'n', 'x' }, 'gra')
    vim.keymap.del('n', 'gri')
    vim.keymap.del('n', 'grt')
    vim.keymap.set('n', 'gd', '<cmd>Glance definitions<CR>', { desc = '[G]oto [D]efinition' })
    vim.keymap.set('n', 'gr', '<cmd>Glance references<CR>', { desc = '[G]oto [R]eferences' })
    vim.keymap.set('n', 'gi', '<cmd>Glance implementations<CR>', { desc = '[G]oto [I]mplementations' })
    vim.keymap.set('n', 'gt', '<cmd>Glance type_definitions<CR>', { desc = '[G]oto [T]ype definitions' })
  end,
}
