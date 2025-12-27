-- Autocompletion
return {
  'saghen/blink.cmp',
  event = 'VimEnter',
  version = '1.*',
  dependencies = {
    -- Snippet engine
    {
      'L3MON4D3/LuaSnip',
      version = '2.*',
      build = (function()
        -- This build step is needed for regex support in snippets.
        -- This step is not supported in many windows environments.
        -- Remove the below condition to re-enable on windows.
        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
          return
        end
        return 'make install_jsregexp'
      end)(),
      opts = {},
    },
    'folke/lazydev.nvim',
    'micangl/cmp-vimtex',
    {
      'saghen/blink.compat',
      version = '*',
      opts = {},
    },
  },
  --- @module 'blink.cmp'
  --- @type blink.cmp.Config
  opts = {
    keymap = {
      -- Default binds:
      -- <c-y>: accept ([y]es) the completion.
      --    This will auto-import if your LSP supports it.
      --    This will expand snippets if the LSP sent a snippet.
      -- <tab>/<s-tab>: move to right/left of snippet expansion
      -- <c-space>: open menu, or open docs if already open
      -- <c-n>/<c-p> or <up>/<down>: select next/previous item
      -- <c-e>: hide menu
      -- <c-k>: toggle signature help
      preset = 'default',
    },

    appearance = {
      nerd_font_variant = 'mono',
    },

    completion = {
      documentation = { auto_show = false, auto_show_delay_ms = 500 },
    },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'lazydev' },
      providers = {
        lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
        vimtex = { name = 'vimtex', min_keyword_length = 2, module = 'blink.compat.source', score_offset = 80 },
      },
    },

    snippets = { preset = 'luasnip' },

    -- Blink.cmp includes an optional rust fuzzy matcher, which automatically
    -- downloads a prebuilt binary when enabled.
    fuzzy = { implementation = 'prefer_rust_with_warning' },

    signature = { enabled = true },
  },
}
