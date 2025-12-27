-- Many small utilities
return {
  'nvim-mini/mini.nvim',
  config = function()
    -- Better Around/Inside text objects
    require('mini.ai').setup({ n_lines = 500 })

    -- Move selections
    require('mini.move').setup()

    -- Add/delete/replace surroundings
    require('mini.surround').setup()
  end,
}
