-- Many QoL plugins
local tmux_bind = function(key, dir, buf)
  vim.keymap.set({ 'i', 't', 'n' }, key, function()
    vim.fn.system('tmux select-pane -' .. dir)
  end, { buffer = buf })
end
local tmux_binds = function(buf)
  tmux_bind('<C-h>', 'L', buf)
  tmux_bind('<C-j>', 'D', buf)
  tmux_bind('<C-k>', 'U', buf)
  tmux_bind('<C-l>', 'R', buf)
end
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
    image = {},
    input = {},
    lazygit = {
      win = {
        on_buf = function(win)
          tmux_binds(win.buf)
        end,
      },
    },
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
    },
  },
  keys = {
    -- Picker
    {
      '<leader><leader>',
      function()
        Snacks.picker.smart()
      end,
      desc = 'Smart find files',
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
        Snacks.picker.lines()
      end,
      desc = 'Grep [B]uffer',
    },
    {
      '<leader>sB',
      function()
        Snacks.picker.grep_buffers()
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
        Snacks.picker.grep()
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
    -- Lazygit
    {
      '<leader>gg',
      function()
        Snacks.lazygit.open()
      end,
      desc = 'Lazy[G]it',
    },
  },
}
