return {
  'nickjvandyke/opencode.nvim',
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {}

    vim.o.autoread = true
  end,
  keys = {
    {
      mode = { 'n', 'x' },
      '<leader>aa',
      function()
        require('opencode').ask('@this: ', { submit = true })
      end,
      desc = 'Ask opencode…',
    },
    {
      mode = { 'n', 'x' },
      '<leader>a<leader>',
      function()
        require('opencode').select()
      end,
      desc = 'Execute opencode action…',
    },
    {
      mode = { 'n', 't' },
      '<leader>at',
      function()
        require('opencode').toggle()
      end,
      desc = 'Toggle opencode',
    },
  },
}
