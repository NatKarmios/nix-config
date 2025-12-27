vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

vim.g.have_nerd_font = vim.env.TERM ~= 'linux'

vim.g.no_ocaml_maps = true -- OCaml LSP binds cause interference

-- Increase limit for nicer diff matching (linematch)
vim.g.diffopt = 'internal,filler,closeoff,inline:simple,linematch:100'

vim.o.number = true -- Line numbers
vim.o.mouse = 'a' -- Enable mouse
vim.o.showmode = false -- Hide mode; statusline will show it
vim.o.breakindent = true -- Wrapped lines preserve indent
vim.o.undofile = true -- Undo history

-- Tab behaviour
vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

-- Ignore case in searches UNLESS \C or capital letters in search term
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.signcolumn = 'yes'
vim.o.updatetime = 250 -- Decrease update time
vim.o.timeoutlen = 300 -- Decrease mapped sequence wait time

-- Set how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Show whitespace characters
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.o.inccommand = 'split' -- Substitutions live preview
vim.o.cursorline = true -- Show which line the cursor is on
vim.o.scrolloff = 10 -- Min lines to keep above and below the cursor

-- Diagnostic message config
vim.diagnostic.config {
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  -- underline = { severity = vim.diagnostic.severity.ERROR },
  signs = vim.g.have_nerd_font and {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  } or {},
  virtual_text = {
    source = 'if_many',
    spacing = 2,
    format = function(diagnostic)
      local diagnostic_message = {
        [vim.diagnostic.severity.ERROR] = diagnostic.message,
        [vim.diagnostic.severity.WARN] = diagnostic.message,
        [vim.diagnostic.severity.INFO] = diagnostic.message,
        [vim.diagnostic.severity.HINT] = diagnostic.message,
      }
      return diagnostic_message[diagnostic.severity]
    end,
  },
}
