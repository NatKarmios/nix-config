{
  lib,
  inputs,
  pkgs,
  ...
}:
with lib.custom.nixvim;
{
  imports = [
    inputs.nixvim.homeModules.nixvim
    ./plugins
    ./theme.nix
  ];

  home.packages = [
    pkgs.neovim-remote
  ];

  programs.nixvim = {
    enable = true;
    enableMan = true;

    extraConfigLuaPre = ''
      local deprecate_ = vim.deprecate
      vim.deprecate = function(name, alternative, version, plugin, backtrace)
        return deprecate_(name, alternative, version, plugin, true)
      end
    '';

    globals = {
      mapleader = " ";
      maplocalleader = "\\";
      have_nerd_font = raw ''
        vim.env.TERM ~= "linux"
      '';

      # Increase limit for nicer diff matching (linematch)
      diffopt = "internal,filler,closeoff,inline:simple,linematch:100";
    };

    opts = {
      number = true; # Line numbers
      mouse = "a"; # Enable mouse
      showmode = false; # Hide mode; statusline will show it
      breakindent = true;
      undofile = true; # Undo history

      # Tab behaviour
      tabstop = 4;
      expandtab = true;
      softtabstop = 4;
      shiftwidth = 4;

      # Ignore case in searches UNLESS \C or capital letters in search term
      ignorecase = true;
      smartcase = true;

      signcolumn = "yes";
      updatetime = 250; # Decrease update time
      timeoutlen = 300; # Decrese mapped sequence wait time

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

      inccommand = "split"; # Substitutions live preview
      cursorline = true; # Show which line the cursor is on
      scrolloff = 10; # Min lines to keep above and below cursor
    };

    keymaps =
      with bind-helpers;
      lib.flatten [
        (n "<Esc>" (cmd "nohlsearch")) # Clear search highlights
        (t' "<Esc><Esc>" ''<C-\\><C-n>'' "Exit terminal mode")

        # Disable arrows in normal mode
        (nv "<left>" (cmd ''echo "Use h to move!"''))
        (nv "<right>" (cmd ''echo "Use l to move!"''))
        (nv "<up>" (cmd ''echo "Use j to move!"''))
        (nv "<down>" (cmd ''echo "Use k to move!"''))

        # My custom bindings; inspired by what I'm used to from DOOM Emacs
        (n' "<leader><Tab>" (cmd "tabn") "Next tab")
        (n' "<leader><S-Tab>" (cmd "tabN") "Previous tab")
        (n' "<leader>bD" (cmd "bufdo :bdelete") "[B]uffer [D]elete All")
        (n' "<leader>bc" (cmd "enew") "[B]uffer [C]reate")
        (n' "<leader>bn" (cmd "bnext") "[B]uffer [N]ext")
        (n' "<leader>bN" (cmd "bNext") "[B]uffer Previous")
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
        callback = rawFn "vim.highlight.on_yank()";
      }
    ];
  };
}
