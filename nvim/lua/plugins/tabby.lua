-- Tabline with named tabs
local api = vim.api

local function rename_tab(tab, on_done)
  local tab_name = require 'tabby.feature.tab_name'
  vim.ui.input({ prompt = 'Tab name: ', default = tab_name.get_raw(tab) }, function(name)
    if name then
      tab_name.set(tab, name) -- '' clears it
    end
    if on_done then
      on_done()
    end
  end)
end

-- :tabmove only moves the current tab, so hop to the target tab with autocmds off
-- (otherwise the picker closes itself on WinLeave), move it, and hop back
local function move_tab(picker, item, delta)
  local target = item.nr + delta
  if target < 1 or target > #api.nvim_list_tabpages() then
    return
  end
  local cur, ei = api.nvim_get_current_tabpage(), vim.o.eventignore
  vim.o.eventignore = 'all'
  pcall(function()
    api.nvim_set_current_tabpage(item.tab)
    vim.cmd.tabmove(delta > 0 and '+1' or '-1')
  end)
  api.nvim_set_current_tabpage(cur)
  vim.o.eventignore = ei
  vim.cmd.redrawtabline()
  picker.list:set_target(target, nil, { force = true }) -- keep the cursor on the moved tab
  picker:refresh()
end

local picker_source = {
  title = 'Tabs',
  finder = function(_, ctx)
    local current = api.nvim_get_current_tabpage()
    local items = {}
    for nr, tab in ipairs(api.nvim_list_tabpages()) do
      -- the current tab's focused window is the picker itself, so use the window it was opened from
      local win = tab == current and ctx.picker.main or api.nvim_tabpage_get_win(tab)
      local name = require('tabby.feature.tab_name').get_raw(tab)
      items[nr] = {
        text = name ~= '' and name or require('tabby.feature.win_name').get(win),
        tab = tab,
        nr = nr,
        current = tab == current,
        buf = api.nvim_win_get_buf(win),
        pos = api.nvim_win_get_cursor(win),
      }
    end
    return items
  end,
  format = function(item)
    return {
      { item.current and '● ' or '  ', 'SnacksPickerSpecial' },
      { tostring(item.nr), 'SnacksPickerIdx' },
      { ' ' },
      { item.text },
    }
  end,
  preview = 'file',
  confirm = function(picker, item)
    picker:close()
    if item then
      api.nvim_set_current_tabpage(item.tab)
    end
  end,
  actions = {
    tab_rename = function(picker, item)
      rename_tab(item.tab, function()
        picker:focus()
        picker:refresh()
      end)
    end,
    tab_move_left = function(picker, item)
      move_tab(picker, item, -1)
    end,
    tab_move_right = function(picker, item)
      move_tab(picker, item, 1)
    end,
    tab_close = function(picker)
      for _, item in ipairs(picker:selected { fallback = true }) do
        if item.current then
          vim.notify("Can't close the tab the picker is open in", vim.log.levels.WARN)
        elseif api.nvim_tabpage_is_valid(item.tab) then
          vim.cmd.tabclose(tostring(api.nvim_tabpage_get_number(item.tab)))
        end
      end
      picker:refresh()
    end,
  },
  win = {
    input = {
      keys = {
        ['<c-e>'] = { 'tab_rename', mode = { 'n', 'i' }, desc = 'Rename tab' },
        ['<a-k>'] = { 'tab_move_left', mode = { 'n', 'i' }, desc = 'Move tab left' },
        ['<a-j>'] = { 'tab_move_right', mode = { 'n', 'i' }, desc = 'Move tab right' },
        ['<c-x>'] = { 'tab_close', mode = { 'n', 'i' }, desc = 'Close tab' },
      },
    },
    list = {
      keys = {
        ['r'] = 'tab_rename',
        ['K'] = 'tab_move_left',
        ['J'] = 'tab_move_right',
        ['dd'] = 'tab_close',
      },
    },
  },
}

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
          rename_tab(api.nvim_get_current_tabpage())
        end,
        desc = '[R]ename tab',
      },
    },
  },
  {
    'folke/snacks.nvim',
    opts = { picker = { sources = { tabs = picker_source } } },
    keys = {
      {
        '<leader>ww',
        function()
          Snacks.picker.pick 'tabs'
        end,
        desc = 'Search tabs',
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
