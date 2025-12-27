require('lazy').setup {
  require 'plugins.theme', -- Catppuccin
  require 'plugins.auto-session', -- Remember what files I had open
  require 'plugins.blink-cmp', -- Autocompletion
  require 'plugins.bufdelete', -- Delete buffers, keep layout
  require 'plugins.conform', -- Autoformat
  'sindrets/diffview.nvim', -- Git diffs
  require 'plugins.dropbar', -- IDE-esque breadcrumb bar
  require 'plugins.fidget', -- Notifications & LSP progress messages
  require 'plugins.glance', -- LSP previews
  require 'plugins.git-blame', -- Git blame in virtual text
  require 'plugins.gitsigns', -- Buffer-wise Git utilities
  require 'plugins.guess-indent', -- Detect tabstop and shiftwidth automatically
  require 'plugins.leap', -- Super powered motion!
  require 'plugins.lsp', -- LSP
  require 'plugins.lualine', -- Statusline
  require 'plugins.mini', -- Many small utilities
  -- require 'plugins.noice', -- UI revamp
  'sitiom/nvim-numbertoggle', -- Auto-toggle relative/absolute nums based on mode
  require 'plugins.smear-cursor', -- Smear the cursor when making large motions
  require 'plugins.snacks', -- Many QoL plugins
  require 'plugins.spider', -- Better w/e/b motions
  require 'plugins.tiny-inline-diagnostic', -- Neater, prettier diagnostics
  require 'plugins.treesitter', -- Utilities based on a smarter syntax parser
  require 'plugins.tmux-navigator', -- Seamless nagivation between tmux panes and vim splits
  'folke/todo-comments.nvim', -- Highlight and searching for to-do comments
  require 'plugins.ufo', -- Better folding
  require 'plugins.which-key', -- Keybind hints
  'tpope/vim-repeat', -- Better . repeat
  require 'plugins.vimtex', -- LaTeX support
  'gelguy/wilder.nvim', -- Better wildmenu
  require 'plugins.yazi', -- File manager
}
