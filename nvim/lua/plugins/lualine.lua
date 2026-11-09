-- Statusline

-- Shown when a dead Neovim left unsaved changes to this file in a swap file (see :recover)
local function recoverable()
  local file = vim.api.nvim_buf_get_name(0)
  if file == '' or vim.bo.buftype ~= '' then
    return ''
  end
  -- Assumes the default '//' swap 'directory' (swap named after the full path)
  local base = vim.split(vim.o.directory, ',')[1] .. file:gsub('/', '%%')
  local own = vim.fs.normalize(vim.fn.swapname(0))
  for c = ('p'):byte(), ('a'):byte(), -1 do -- .swp, .swo, ... .swa
    local swap = vim.fs.normalize(base .. '.sw' .. string.char(c))
    if swap ~= own and vim.uv.fs_stat(swap) then
      local info = vim.fn.swapinfo(swap)
      if info.dirty == 1 and info.pid == 0 then -- pid is 0 once its owner has exited
        return '[recoverable]'
      end
    end
  end
  return ''
end

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      component_separators = {
        left = '',
        right = '',
      },
      section_separators = {
        left = '',
        right = '',
      },
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = {
        'branch',
        'diff',
        'diagnostics',
      },
      lualine_c = { 'filename', { recoverable, color = 'DiagnosticError' } },

      lualine_x = { 'filetype' },
      lualine_y = { 'progress' },
      lualine_z = { 'location' },
    },
  },
}
