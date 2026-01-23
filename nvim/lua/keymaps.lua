local map = function(opts)
  vim.keymap.set(opts.mode or 'n', opts[1], opts[2], { desc = opts.desc })
end

map { '<Esc>', '<cmd>nohlsearch<CR>' } -- Clear search highlights
map { mode = 't', '<Esc><Esc>', '<C-\\><C-n>', desc = 'Exit terminal mode' }

-- Disable arrows in normal mode
map { mode = { 'n', 'v' }, '<left>', '<cmd>echo "Use h to move!"<CR>' }
map { mode = { 'n', 'v' }, '<right>', '<cmd>echo "Use l to move!"<CR>' }
map { mode = { 'n', 'v' }, '<up>', '<cmd>echo "Use k to move!"<CR>' }
map { mode = { 'n', 'v' }, '<down>', '<cmd>echo "Use j to move!"<CR>' }

-- My custom bindings; inspired by what I was used to from DOOM Emacs
map { '<leader><Tab>', '<cmd>tabn<CR>', desc = 'Next tab' }
map { '<leader><S-Tab>', '<cmd>tabp<CR>', desc = 'Previous tab' }
map { '<leader>bD', '<cmd>bufdo :bdelete<CR>', desc = '[B]uffer [D]elete all' }
map { '<leader>bc', '<cmd>enew<CR>', desc = '[B]uffer [C]reate' }
map { '<leader>bn', '<cmd>bnext', desc = '[B]uffer [N]ext' }
map { '<leader>bN', '<cmd>bNext', desc = '[B]uffer Previous' }
map { 'gb', '<C-o>', desc = '[G]o [B]ack' }
map { 'gB', '<C-i>', desc = '[G]o Forward' }
map { mode = 'i', 'jj', '<Esc>' }

-- Some LSP things
map { mode = { 'n', 'x' }, '<leader>ca', vim.lsp.buf.code_action, desc = 'LSP Code [A]ction' }
map { '<leader>cc', vim.lsp.buf.hover, desc = 'LSP Hover' }
map { '<leader>cr', vim.lsp.buf.rename, desc = 'LSP [R]ename' }

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('nat-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})
