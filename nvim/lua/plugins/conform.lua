-- Autoformat
return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>cf',
      function()
        require('conform').format { async = true }
      end,
      desc = '[F]ormat buffer',
    }
  },
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
    },
    default_format_opts = {
      lsp_format = 'prefer',
    },
    format_on_save = { timeout_ms = 500 },
  },
  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end
}
