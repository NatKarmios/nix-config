-- IDE-esque breadcrumb bar
return {
  'Bekaboo/dropbar.nvim',
  lazy = false,
  opts = {
    bar = {
      attach_events = {
        'TermOpen',
        'BufWinEnter',
        'BufWritePost',
        'LspAttach',
      },
    },
  },
}
