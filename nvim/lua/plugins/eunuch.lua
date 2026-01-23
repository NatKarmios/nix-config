-- File utility commands
return {
  'tpope/vim-eunuch',
  lazy = false,
  keys = {
    {
      '<leader>fd',
      function()
        local name = vim.fs.basename(vim.api.nvim_buf_get_name(0))
        vim.ui.input({ prompt = 'Really delete ' .. name .. '? (y) ' }, function(input)
          if input ~= nil and string.lower(vim.trim(input)) == 'y' then
            vim.api.nvim_command 'Remove'
            vim.api.nvim_command 'bd!'
            print('Deleted ' .. name)
          end
        end)
      end,
      desc = '[D]elete file',
    },
  },
}
