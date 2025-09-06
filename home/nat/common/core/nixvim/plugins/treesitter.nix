# Utilities based on a smarter syntax parser
{
  programs.nixvim = {
    plugins.treesitter = {
      enable = true;
      settings = {
        highlight.enable = true;
        incremental_selection.enable = true;
      };
    };
  };
}

