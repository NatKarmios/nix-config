-- Keybind hints
return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  opts_extend = { 'spec' },
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
      { '<leader>a', group = '[A]I' },
      { '<leader>b', group = '[B]uffer' },
      { '<leader>c', group = '[C]ode' },
      { '<leader>f', group = '[F]ile' },
      { '<leader>g', group = '[G]it' },
      { '<leader>s', group = '[S]earch' },
      { '<leader>t', group = '[T]oggle' },
      {
        '<leader>w',
        group = 'Tabs',
        expand = function()
          local keys = {}
          for i, tab in ipairs(vim.api.nvim_list_tabpages()) do
            if i < 10 then
              local buf = vim.api.nvim_win_get_buf(vim.api.nvim_tabpage_get_win(tab))
              local name = vim.api.nvim_buf_get_name(buf)
              table.insert(keys, {
                tostring(i),
                function()
                  vim.api.nvim_set_current_tabpage(tab)
                end,
                desc = name ~= '' and vim.fn.fnamemodify(name, ':~:.') or '[No Name]',
              })
            end
          end
          return keys
        end,
      },
    },
  },
}
