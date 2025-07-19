{ lib, inputs, pkgs, ... }:
with lib.custom.nixvim;
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./plugins/cmp.nix
    ./plugins/lsp
    ./plugins/sidebar.nix
    ./plugins/spider.nix
    ./plugins/telescope.nix
    ./plugins/ufo.nix
    ./plugins/which-key.nix
  ];

  home.packages = [
    pkgs.neovim-remote
  ];

  programs.nixvim = {
    enable = true;
    enableMan = true;
    colorschemes.catppuccin.enable = true;

    globals = {
      mapleader = " ";
      maplocalleader = " ";
      have_nerd_font = raw ''
        vim.env.TERM ~= "linux"
      '';
    };

    opts = {
      number = true;  # Line numbers
      mouse = "a";  # Enable mouse
      showmode = false;  # Hide mode; statusline will show it
      breakindent = true;
      undofile = true;  # Undo history

      # Ignore case in searches UNLESS \C or capital letters in search term
      ignorecase = true;
      smartcase = true;

      signcolumn = "yes";
      updatetime = 250;  # Decrease update time
      timeoutlen = 300;  # Decrese mapped sequence wait time

      # Set how new splits should be opened
      splitright = true;
      splitbelow = true;

      # Show whitespace characters
      list = true;
      listchars = {
        tab = "» ";
        trail = "·";
        nbsp = "␣";
      };

      inccommand = "split";  # Substitutions live preview
      cursorline = true;  # Show which line the cursor is on
      scrolloff = 10;  # Min lines to keep above and below cursor

    };

    plugins = {
      gitsigns.enable = true;  # Add git signs to the gutter
      lazygit.enable = true;  # Embedded git porcelain
      leap.enable = true;  # Super powered motion!
      numbertoggle.enable = true;  # Auto-toggle relative/absolute nums based on mode
      sleuth.enable = true;  # Configure tabs and indents automatically
    };

    keymaps = with bind-helpers; lib.flatten [
      (n "<Esc>" (cmd "nohlsearch")) # Clear search highlights
      (t' "<Esc><Esc>" ''<C-\\><C-n>'' "Exit terminal mode")

      # Disable arrows in normal mode
      (nv "<left>" (cmd ''echo "Use h to move!"''))
      (nv "<right>" (cmd ''echo "Use l to move!"''))
      (nv "<up>" (cmd ''echo "Use j to move!"''))
      (nv "<down>" (cmd ''echo "Use k to move!"''))

      # Nicer split navigation
      (n' "<C-h>" "<C-w><C-h>" "Move focus to the left window")
      (n' "<C-l>" "<C-w><C-h>" "Move focus to the right window")
      (n' "<C-j>" "<C-w><C-h>" "Move focus to the lower window")
      (n' "<C-k>" "<C-w><C-h>" "Move focus to the upper window")

      # My custom bindings; inspired by what I'm used to from DOOM Emacs
      (n' "<leader><Tab>" (cmd "tabn") "Next tab")
      (n' "<leader><S-Tab>" (cmd "tabN") "Previous tab")
      (n' "<leader>bd" (cmd "bd") "[B]uffer [D]elete")
      (n' "<leader>bc" (cmd "bc") "[B]uffer [C]reate")
      (n' "<leader>bn" (cmd "bn") "[B]uffer [N]ext")
      (n' "<leader>bN" (cmd "bN") "[B]uffer Previous")
      (n' "gb" "<C-o>" "[G]o [B]ack")
      (n' "gB" "<C-i>" "[G]o Forward")
      (i "jj" "<Esc>")
    ];

    autoGroups = {
      nat-highlight-yank.clear = true;
    };

    autoCmd = [
      {
        event = "TextYankPost";
        desc = "Highlight when yanking text";
        group = "nat-highlight-yank";
        callback = raw "function() vim.highlight.on_yank() end";
      }
    ];
  };
}

