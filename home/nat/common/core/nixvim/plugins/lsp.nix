{ lib, ... }:
with lib.custom.nixvim;
{
  programs.nixvim = {

    globals.no_ocaml_maps = true;  # OCaml LSP binds cause interference

    diagnostic.settings = {
      severity_sort = true;
      float = { border = "rounded"; source = "if_many"; };
      underline = { severify = raw "vim.diagnostic.severity.ERROR"; };
      signs = (raw ''
        vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {}
      '');
      virtual_text = {
        source = "if_many";
        spacing = 2;
        format = raw ''
          function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end
        '';
      };
    };

    plugins = {
      cmp-nvim-lsp.enable = true;
      cmp-nvim-lsp-signature-help.enable = true;
      fidget.enable = true;
    };

    plugins.lsp = {
      enable = true;
      servers = {
        nixd.enable = true;
        rust_analyzer.enable = true;
      };

      keymaps.extra = with bind-helpers; lib.flatten [
        (n' "<leader>q" (raw "vim.diagnostic.setloclist") "Open diagnostic [Q]uickfix list")

        (prependRawAction "vim.lsp.buf." [
          (n' "gD" "declaration" "[G]oto [D]eclaration")
          (n' "<leader>cr" "rename" "[R]ename symbol")
          (nx' "<leader>ca" "code_action" "[C]ode [A]ction")
          (n' "<leader>cc" "hover" "[C]ode Hover")
        ])

        (prependRawAction "require('telescope.builtin').lsp_" [
          (n' "gd" "definitions" "[G]oto [D]efinition")
          (n' "gr" "references" "[G]oto [R]eferences")
          (n' "gI" "implementations" "[G]oto [I]mplementation")
          (n' "gt" "type_definitions" "[G]oto [T]ype definition")
          (n' "<leader>fs" "document_symbols" "[F]ind document [S]ymbols")
          (n' "<leader>fS" "dynamic_workspace_symbols" "[F]ind workspace [S]ymbols")
        ])
      ];

      # Auto-highlight references, toggle inlay hints
      onAttach = ''
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

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
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

        -- The following code creates a keymap to toggle inlay hints in your
        -- code, if the language server you are using supports them
        --
        -- This may be unwanted, since they displace some of your code
        if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
          vim.keymap.set('n', '<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
          end, { buffer = event.buf, desc = 'LSP: [T]oggle Inlay [H]ints' })
        end
      '';
    };

  };
}
