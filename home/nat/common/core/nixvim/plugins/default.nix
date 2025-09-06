{
  imports = [
    ./cmp.nix
    ./lean.nix
    ./leap.nix
    ./lsp
    ./lualine.nix
    ./nvim-tree.nix
    ./sidebar.nix
    ./smear-cursor.nix
    ./snacks.nix
    ./spider.nix
    ./surround.nix
    ./telescope.nix
    ./treesitter.nix
    ./ufo.nix
    ./which-key.nix
    ./yazi.nix
  ];

  programs.nixvim.plugins = {
    auto-session = {
      # Remember the files I have open in specific dirs
      enable = true;

      # Don't make sessions automatically; enable it for a dir with :SessionSave
      settings.auto_create = false;
    };
    diffview.enable = true;
    dropbar = {
      # IDE-esque breadcrumb bar
      enable = true;
      settings.bar.attach_events = [
        "TermOpen"
        "BufWinEnter"
        "BufWritePost"
        "LspAttach"
      ];
    };
    fidget = {
      # Notifications & LSP progress messages
      enable = true;
      settings.notification.window.winblend = 0;
    };
    flit.enable = true; # Better f/F/t/T, based on leap
    gitblame = {
      # Git blame in virtual text
      enable = true;
      settings.enabled = false;
    };
    gitsigns.enable = true; # Add git signs to the gutter
    numbertoggle.enable = true; # Auto-toggle relative/absolute nums based on mode
    sleuth.enable = true; # Configure tabs and indents automatically
    tiny-inline-diagnostic = {
      # Neater, prettier diagnostics
      enable = true;
      luaConfig.post = ''
        vim.diagnostic.config({ virtual_text = false })
      '';
    };
    todo-comments.enable = true; # Highlight and searching for to-do comments
    web-devicons.enable = true; # Helpers for Nerd Font icons
    wilder.enable = true; # Better wildmenu
  };
}
