vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>') -- Clear search highlights
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Disable arrows in normal mode
vim.keymap.set({ 'n', 'v' }, '<left>', '<cmd>echo "Use h to move!"<CR>')
vim.keymap.set({ 'n', 'v' }, '<right>', '<cmd>echo "Use l to move!"<CR>')
vim.keymap.set({ 'n', 'v' }, '<up>', '<cmd>echo "Use k to move!"<CR>')
vim.keymap.set({ 'n', 'v' }, '<down>', '<cmd>echo "Use j to move!"<CR>')

-- My custom bindings; inspired by what I was used to from DOOM Emacs
vim.keymap.set('n', '<leader><Tab>', '<cmd>tabn<CR>', { desc = 'Next tab' })
vim.keymap.set('n', '<leader><S-Tab>', '<cmd>tabp<CR>', { desc = 'Previous tab' })
vim.keymap.set('n', '<leader>bD', '<cmd>bufdo :bdelete<CR>', { desc = '[B]uffer [D]elete all' })
vim.keymap.set('n', '<leader>bc', '<cmd>enew<CR>', { desc = '[B]uffer [C]reate' })
vim.keymap.set('n', '<leader>bn', '<cmd>bnext', { desc = '[B]uffer [N]ext' })
vim.keymap.set('n', '<leader>bN', '<cmd>bNext', { desc = '[B]uffer Previous' })
vim.keymap.set('n', 'gb', '<C-o>', { desc = '[G]o [B]ack' })
vim.keymap.set('n', 'gB', '<C-i>', { desc = '[G]o Forward' })
vim.keymap.set('i', 'jj', '<Esc>')

-- Some LSP things
vim.keymap.set({ 'n', 'x' }, '<leader>ca', vim.lsp.buf.code_action, { desc = 'LSP Code [A]ction' })
vim.keymap.set('n', '<leader>cc', vim.lsp.buf.hover, { desc = 'LSP Hover' })
vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, { desc = 'LSP [R]ename' })

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('nat-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})
