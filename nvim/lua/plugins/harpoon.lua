-- Quick navigation of marked files

-- Cobbled from a couple sources
-- https://github.com/ThePrimeagen/harpoon/issues/696
-- https://github.com/xunafay/kickstart.nvim/blob/master/lua/custom/harpoon/snacks.lua
local picker_source = {
  finder = function()
    local output = {}
    for i, item in pairs(require('harpoon'):list().items) do
      if item and item.value:match '%S' then
        table.insert(output, {
          hidx = i,
          text = item.value,
          file = item.value,
          pos = { item.context.row, item.context.col },
        })
      end
    end
    return output
  end,
  filter = {
    transform = function()
      return true
    end,
  },
  format = function(item)
    local fmt = {
      { tostring(item.hidx), 'SnacksPickerIdx' },
      { ' ' },
      { item.text },
      { ':', 'SnacksPickerDelim' },
      { tostring(item.pos[1]), 'SnacksPickerRow' },
    }
    return fmt
  end,
  preview = function(ctx)
    if Snacks.picker.util.path(ctx.item) then
      return Snacks.picker.preview.file(ctx)
    else
      return Snacks.picker.preview.none(ctx)
    end
  end,
  confirm = 'jump',
  actions = {
    remove = function(picker, item)
      if not item then
        vim.notify('No item selected', vim.log.levels.WARN)
        return
      end

      local list = require('harpoon'):list()
      list:remove_at(item.hidx)

      if #list.items == 0 then
        picker:close()
      else
        picker:refresh()
      end
    end,
  },
  win = {
    input = {
      keys = {
        ['<c-x>'] = { 'remove', mode = { 'n', 'i' } },
      },
    },
    list = {
      keys = {
        ['<c-x>'] = 'remove',
        ['dd'] = 'remove',
      },
    },
  },
}

return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require 'harpoon'
      harpoon.setup {}
      harpoon:extend {
        ADD = function(cx)
          print('Added harpoon ' .. cx.idx)
        end,
        REMOVE = function(cx)
          print('Removed harpoon ' .. cx.idx)
        end,
      }
    end,
    keys = {
      {
        '<leader>ha',
        function()
          require('harpoon'):list():add()
        end,
        desc = '[A]dd harpoon',
      },
      {
        '<leader>hd',
        function()
          require('harpoon'):list():remove()
        end,
        desc = '[D]elete harpoon',
      },
      {
        ']h',
        function()
          require('harpoon'):list():next()
        end,
        desc = 'Next [h]arpoon',
      },
      {
        '[h',
        function()
          require('harpoon'):list():prev()
        end,
        desc = 'Previous [h]arpoon',
      },
    },
  },
  {
    'folke/snacks.nvim',
    opts = {
      picker = {
        sources = {
          harpoon = picker_source,
        },
      },
    },
    keys = {
      {
        '<leader>hh',
        function()
          Snacks.picker.pick 'harpoon'
        end,
        desc = 'Search [h]arpoons',
      },
    },
  },
  {
    'folke/which-key.nvim',
    opts = {
      spec = {
        {
          '<leader>h',
          group = '[H]arpoon',
          expand = function()
            local list = require('harpoon'):list()
            local keys = {}
            for i, item in pairs(list.items) do
              if type(i) == 'number' and i < 10 then
                table.insert(keys, {
                  tostring(i),
                  function()
                    list:select(i)
                  end,
                  desc = item.value,
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
