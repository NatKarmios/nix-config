-- Git TUI

-- Binds to make tmux navigation work properly
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

return {
  'folke/snacks.nvim',
  opts = {
    lazygit = {
      win = {
        on_buf = function(win)
          tmux_binds(win.buf)
        end,
      },
    },
  },
  keys = {
    {
      '<leader>gg',
      function()
        Snacks.lazygit.open()
      end,
      desc = 'Lazy[G]it',
    },
  },
}
