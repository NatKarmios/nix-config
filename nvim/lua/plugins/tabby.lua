-- Tabline with named tabs
return {
  {
    'nanozuki/tabby.nvim',
    lazy = false, -- `keys` would otherwise lazy-load it, and the tabline is needed at startup
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    init = function()
      -- Tabby stores tab names in g:TabbyTabNames, which sessions only save with 'globals'
      vim.opt.sessionoptions:append 'globals'
    end,
    ---@type TabbyConfig
    opts = {
      preset = 'tab_only',
      option = { nerdfont = vim.g.have_nerd_font },
    },
    keys = {
      {
        '<leader>wr',
        function()
          local tab_name = require 'tabby.feature.tab_name'
          vim.ui.input({ prompt = 'Tab name: ', default = tab_name.get_raw(0) }, function(name)
            if name then
              tab_name.set(0, name) -- '' clears it
            end
          end)
        end,
        desc = '[R]ename tab',
      },
    },
  },
  {
    'folke/which-key.nvim',
    opts = {
      spec = {
        {
          '<leader>w',
          group = 'Tabs',
          expand = function()
            local keys = {}
            for i, tab in ipairs(vim.api.nvim_list_tabpages()) do
              if i < 10 then
                table.insert(keys, {
                  tostring(i),
                  function()
                    vim.api.nvim_set_current_tabpage(tab)
                  end,
                  desc = require('tabby.feature.tab_name').get(tab),
                })
              end
            end
            return keys
          end,
        },
      },
    },
  },
}
