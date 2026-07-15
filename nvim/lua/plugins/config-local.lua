-- Per-project nvim configuration
return {
  'klen/nvim-config-local',
  lazy = false,
  config = function()
    require('config-local').setup()
  end
}

