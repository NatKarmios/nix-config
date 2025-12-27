return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  opts = {
    transparent_background = true,

    -- https://github.com/catppuccin/nvim#integrations
    integrations = {
      blink_cmp = {
        style = 'bordered',
      },
      dropbar = {
        enabled = true,
        color_mode = true,
      },
      fidget = true,
      gitsigns = true,
      leap = true,
      mini = { enabled = true },
      nvimtree = true,
      snacks = {
        enabled = true,
      },
      telescope = { enabled = true },
      ufo = true,
      which_key = true,
    },
  },
  config = function(_, opts)
    require('catppuccin').setup(opts)
    vim.cmd.colorscheme('catppuccin')
  end,
}
