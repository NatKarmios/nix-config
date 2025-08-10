{
  stylix.targets.nixvim.enable = false;

  programs.nixvim = {
    colorschemes.catppuccin = {
      enable = true;
      settings = {
        transparent_background = true;

        # https://github.com/catppuccin/nvim#integrations
        integrations = {
          cmp = true;
          dropbar = {
            enabled = true;
            color_mode = true;
          };
          fidget = true;
          gitsigns = true;
          leap = true;
          mini.enabled = true;
          nvimtree = true;
          snacks = true;
          telescope.enabled = true;
          ufo = true;
          which_key = true;
        };
      };
    };
  };
}
