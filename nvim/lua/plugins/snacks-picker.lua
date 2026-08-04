-- Picker & fuzzy finder

-- Binds to make tmux navigation work properly
local tmux_key = function(dir)
  return {
    function()
      vim.fn.system('tmux select-pane -' .. dir)
    end,
    mode = { 'n', 'i', 't' },
  }
end

return {
  'folke/snacks.nvim',
  opts = {
    picker = {
      actions = {
        opencode_send = function(...)
          return require('opencode').snacks_picker_send(...)
        end,
      },
      win = {
        input = {
          keys = {
            ['<a-a>'] = { 'opencode_send', mode = { 'n', 'i' } },
            ['<C-h>'] = tmux_key 'L',
            ['<C-j>'] = tmux_key 'D',
            ['<C-k>'] = tmux_key 'U',
            ['<C-l>'] = tmux_key 'R',
          },
        },
      },
      sources = {
        git_grep_hunks = {
          supports_live = false,
          format = function(item, picker)
            local file_format = Snacks.picker.format.file(item, picker)
            vim.api.nvim_set_hl(0, 'SnacksPickerGitGrepLineNew', { link = 'Added' })
            vim.api.nvim_set_hl(0, 'SnacksPickerGitGrepLineOld', { link = 'Removed' })
            if item.sign == '+' then
              file_format[#file_format - 1][2] = 'SnacksPickerGitGrepLineNew'
            else
              file_format[#file_format - 1][2] = 'SnacksPickerGitGrepLineOld'
            end
            return file_format
          end,
          finder = function(_, ctx)
            local hcount = 0
            local header = {
              file = '',
              old = { start = 0, count = 0 },
              new = { start = 0, count = 0 },
            }
            local sign_count = 0
            return require('snacks.picker.source.proc').proc(
              ctx:opts {
                cmd = 'git',
                args = { 'diff', '--unified=0' },
                transform = function(item) ---@param item snacks.picker.finder.Item
                  local line = item.text
                  -- [[Header]]
                  if line:match '^diff' then
                    hcount = 3
                  elseif hcount > 0 then
                    if hcount == 1 then
                      header.file = line:sub(7)
                    end
                    hcount = hcount - 1
                  elseif line:match '^@@' then
                    local parts = vim.split(line:match '@@ ([^@]+) @@', ' ')
                    local old_start, old_count = parts[1]:match '-(%d+),?(%d*)'
                    local new_start, new_count = parts[2]:match '+(%d+),?(%d*)'
                    header.old.start, header.old.count = tonumber(old_start), tonumber(old_count) or 1
                    header.new.start, header.new.count = tonumber(new_start), tonumber(new_count) or 1
                    sign_count = 0
                  -- [[Body]]
                  elseif not line:match '^[+-]' then
                    sign_count = 0
                  elseif line:match '^[+-]%s*$' then
                    sign_count = sign_count + 1
                  else
                    item.sign = line:sub(1, 1)
                    item.file = header.file
                    item.line = line:sub(2)
                    if item.sign == '+' then
                      item.pos = { header.new.start + sign_count, 0 }
                      sign_count = sign_count + 1
                    else
                      item.pos = { header.new.start, 0 }
                      sign_count = 0
                    end
                    return true
                  end
                  return false
                end,
              },
              ctx
            )
          end,
        },
      },
    },
  },
  keys = {
    {
      '<leader><leader>',
      function()
        Snacks.picker.smart()
      end,
      desc = 'Smart find files',
    },
    {
      '<leader>gs',
      function()
        Snacks.picker.pick 'git_grep_hunks'
      end,
      desc = '[S]earch hunks',
    },
    {
      '<leader>s.',
      function()
        Snacks.picker.resume()
      end,
      desc = 'Resume search',
    },
    {
      '<leader>,',
      function()
        Snacks.picker.buffers()
      end,
      desc = 'Search buffers',
    },
    {
      '<leader>s"',
      function()
        Snacks.picker.registers()
      end,
      desc = 'Registers',
    },
    {
      '<leader>s/',
      function()
        Snacks.picker.search_history()
      end,
      desc = 'Search [H]istory',
    },
    {
      '<leader>sb',
      function()
        Snacks.picker.lines { args = { '--auto-hybrid-regex' } }
      end,
      desc = 'Grep [B]uffer',
    },
    {
      '<leader>sB',
      function()
        Snacks.picker.grep_buffers { args = { '--auto-hybrid-regex' } }
      end,
      desc = 'Grep open [B]uffers',
    },
    {
      '<leader>sc',
      function()
        Snacks.picker.commands()
      end,
      desc = '[C]ommands',
    },
    {
      '<leader>sC',
      function()
        Snacks.picker.command_history()
      end,
      desc = '[C]ommand history',
    },
    {
      '<leader>sd',
      function()
        Snacks.picker.diagnostics_buffer()
      end,
      desc = 'Buffer [D]iagnostics',
    },
    {
      '<leader>sD',
      function()
        Snacks.picker.diagnostics()
      end,
      desc = 'All [D]iagnostics',
    },
    {
      '<leader>sf',
      function()
        Snacks.picker.files()
      end,
      desc = '[F]iles',
    },
    {
      '<leader>sg',
      function()
        Snacks.picker.grep { args = { '--auto-hybrid-regex' } }
      end,
      desc = '[G]rep',
    },
    {
      '<leader>sh',
      function()
        Snacks.picker.help()
      end,
      desc = '[H]elp',
    },
    {
      '<leader>si',
      function()
        Snacks.picker.icons()
      end,
      desc = '[I]cons',
    },
    {
      '<leader>sj',
      function()
        Snacks.picker.jumps()
      end,
      desc = '[J]umps',
    },
    {
      '<leader>sk',
      function()
        Snacks.picker.keymaps()
      end,
      desc = '[K]eymaps',
    },
    {
      '<leader>sl',
      function()
        Snacks.picker.loclist()
      end,
      desc = '[L]ocation list',
    },
    {
      '<leader>sm',
      function()
        Snacks.picker.marks()
      end,
      desc = '[M]arks',
    },
    {
      '<leader>sn',
      function()
        Snacks.picker.notifications()
      end,
      desc = '[N]otification history',
    },
    {
      '<leader>sq',
      function()
        Snacks.picker.qflist()
      end,
      desc = '[Q]uickfix list',
    },
    {
      '<leader>ss',
      function()
        Snacks.picker.lsp_symbols()
      end,
      desc = 'LSP [S]ymbols',
    },
    {
      '<leader>sS',
      function()
        Snacks.picker.lsp_workspace_symbols()
      end,
      desc = 'LSP Workspace [S]ymbols',
    },
    {
      '<leader>st',
      function()
        Snacks.picker.todo_comments()
      end,
      desc = '[T]odo comments',
    },
    {
      '<leader>su',
      function()
        Snacks.picker.undo()
      end,
      desc = '[U]ndo history',
    },
  },
}
