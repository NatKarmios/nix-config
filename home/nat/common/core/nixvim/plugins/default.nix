{
  imports = [
    ./cmp.nix
    ./leap.nix
    ./lsp
    ./lualine.nix
    ./sidebar.nix
    ./spider.nix
    ./surround.nix
    ./telescope.nix
    ./ufo.nix
    ./which-key.nix
    ./yazi.nix
  ];

  programs.nixvim.plugins = {
    auto-session.enable = true; # Automatic session management
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
    lazygit.enable = true; # Embedded git porcelain
    numbertoggle.enable = true; # Auto-toggle relative/absolute nums based on mode
    sleuth.enable = true; # Configure tabs and indents automatically
  };
}
