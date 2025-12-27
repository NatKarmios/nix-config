-- Better w/e/b motions
return {
  'chrisgrieser/nvim-spider',
  -- keys = {
  --   {
  --     mode = { 'n', 'o', 'x' },
  --     'w',
  --     function()
  --       require('spider').motion 'w'
  --     end,
  --   },
  --   {
  --     mode = { 'n', 'o', 'x' },
  --     'e',
  --     function()
  --       require('spider').motion 'e'
  --     end,
  --   },
  --   {
  --     mode = { 'n', 'o', 'x' },
  --     'b',
  --     function()
  --       require('spider').motion 'b'
  --     end,
  --   },
  -- },
  keys = (vim
    .iter({ 'w', 'e', 'b', 'ge' })
    :map(function(x)
      return {
        mode = { 'n', 'o', 'x' },
        x,
        function()
          require('spider').motion(x)
        end,
      }
    end)
    :totable()),
}
