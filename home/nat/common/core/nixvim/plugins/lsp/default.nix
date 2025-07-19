{ lib, ... }:
with lib.custom.nixvim;
{
  imports = [
    ./glance.nix
  ];

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
          (n' "<leader>fs" "document_symbols" "[F]ind document [S]ymbols")
          (n' "<leader>fS" "dynamic_workspace_symbols" "[F]ind workspace [S]ymbols")
        ])
      ];

      # Auto-highlight references, toggle inlay hints
      onAttach = builtins.readFile ./onAttach.lua;
    };

  };
}

