-- File utility commands
return {
  'tpope/vim-eunuch',
  lazy = false,
  keys = {
    {
      '<leader>fd',
      function()
        local name = vim.fs.basename(vim.api.nvim_buf_get_name(0))
        if vim.fn.confirm('Really delete ' .. name .. '?', '&Yes\n&No', 2) == 1 then
          vim.cmd 'Remove!' -- without ! it refuses buffers longer than 'undoreload'
          vim.cmd 'Bdelete!' -- not :bd!, which closes the window (the bd abbreviation only expands when typed)
          print('Deleted ' .. name)
        end
      end,
      desc = '[D]elete file',
    },
    {
      '<leader>fr',
      function()
        local name = vim.fs.basename(vim.api.nvim_buf_get_name(0))
        vim.ui.input({ prompt = 'Rename to: ', default = name }, function(new)
          if new and new ~= '' and new ~= name then
            vim.cmd.Rename(new) -- relative to the file's directory; refuses to overwrite
            print('Renamed ' .. name .. ' to ' .. new)
          end
        end)
      end,
      desc = '[R]ename file',
    },
  },
}
