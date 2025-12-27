-- Keybind hints
return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  opts = {
    delay = 0,
    mappings = vim.g.have_nerd_font,

    -- Use icons if nerd font is enabled, otherwise use text representations
    keys = vim.g.have_nerd_font and {} or {
      Up = '<Up> ',
      Down = '<Down> ',
      Left = '<Left> ',
      Right = '<Right> ',
      C = '<C-…> ',
      M = '<M-…> ',
      D = '<D-…> ',
      S = '<S-…> ',
      CR = '<CR> ',
      Esc = '<Esc> ',
      ScrollWheelDown = '<ScrollWheelDown> ',
      ScrollWheelUp = '<ScrollWheelUp> ',
      NL = '<NL> ',
      BS = '<BS> ',
      Space = '<Space> ',
      Tab = '<Tab> ',
      F1 = '<F1>',
      F2 = '<F2>',
      F3 = '<F3>',
      F4 = '<F4>',
      F5 = '<F5>',
      F6 = '<F6>',
      F7 = '<F7>',
      F8 = '<F8>',
      F9 = '<F9>',
      F10 = '<F10>',
      F11 = '<F11>',
      F12 = '<F12>',
    },

    -- Document existing key chains
    spec = {
      { '<leader>b', group = '[B]uffer' },
      { '<leader>c', group = '[C]ode' },
      { '<leader>f', group = '[F]ind' },
      { '<leader>F', group = '[F]ile' },
      { '<leader>s', group = '[S]earch' },
      { '<leader>t', group = '[T]oggle' },
      { '<leader>w', group = '[W]indow' },
      { '<leader>W', group = 'Tab' },
    },
  }
}
