{
  programs.nixvim = {
    plugins.mini-surround = {
      enable = true;
      # 's' is already used by Leap
      luaConfig.content = ''
        require('mini.surround').setup {
          mappings = {
            add = '<C-s>a',
            delete = '<C-s>d',
            find = '<C-s>f',
            find_left = '<C-s>F',
            highlight = '<C-s>h',
            replace = '<C-s>r',
            update_n_lines = '<C-s>n',
          },
        }
      '';
    };
  };
}
