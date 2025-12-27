-- LSP
return {
  'neovim/nvim-lspconfig',
  init = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('nat-lsp-attach', { clear = true }),
      callback = function(event)
        -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
        ---@param client vim.lsp.Client
        ---@param method vim.lsp.protocol.Method
        ---@param bufnr? integer some lsp support methods only in specific files
        ---@return boolean
        local function client_supports_method(client, method, bufnr)
          if vim.fn.has 'nvim-0.11' == 1 then
            return client:supports_method(method, bufnr)
          else
            return client.supports_method(method, { bufnr = bufnr })
          end
        end

        -- Highlights references of the word under cursor when resting
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if
          client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
        then
          local highlight_augroup = vim.api.nvim_create_augroup('nat-lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('nat-lsp-detach', { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds { group = 'nat-lsp-highlight', buffer = event2.buf }
            end,
          })
        end

        -- Inlay hints
        if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
          vim.keymap.set('n', '<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
          end, { desc = '[T]oggle LSP Inlay [H]ints' })
        end
      end,
    })

    vim.lsp.enable 'html'
    vim.lsp.enable 'jsonls'
    vim.lsp.enable 'cssls'
    vim.lsp.enable 'eslint'

    local flake = 'import (builtins.getFlake "' .. vim.env.FLAKE .. '")'
    local nixOptions = flake .. '.outputs.nixosConfigurations.' .. vim.loop.os_gethostname() .. '.options'
    local hmOptions = nixOptions .. '.home-manager.users.type.getSubOptions'
    vim.lsp.config('nixd', {
      settings = {
        nixd = {
          nixpkgs = {
            expr = (flake .. '.inputs.nixpkgs { }'),
          },
          formatting = {
            command = { 'nixfmt' },
          },
          options = {
            nixos = {
              expr = nixOptions,
            },
            home_manager = {
              expr = hmOptions,
            },
          },
        },
      },
    })
    vim.lsp.enable 'nixd'

    vim.lsp.enable 'ocamllsp'
  end,
}
