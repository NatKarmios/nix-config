{
  imports = [
    ./cmp.nix
    ./lean.nix
    ./leap.nix
    ./lsp
    ./lualine.nix
    ./nvim-tree.nix
    ./sidebar.nix
    ./snacks.nix
    ./spider.nix
    ./surround.nix
    ./telescope.nix
    ./ufo.nix
    ./which-key.nix
    ./yazi.nix
  ];

  programs.nixvim.plugins = {
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
    gitsigns.enable = true; # Add git signs to the gutter
    numbertoggle.enable = true; # Auto-toggle relative/absolute nums based on mode
    sleuth.enable = true; # Configure tabs and indents automatically
    web-devicons.enable = true; # Helpers for Nerd Font icons
  };
}
