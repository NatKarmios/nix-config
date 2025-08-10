{ lib, ... }:
with lib.custom.nixvim;
{
  programs.nixvim = {
    plugins.nvim-tree = {
      enable = true;
      autoClose = true;
    };

    keymaps =
      with bind-helpers;
      lib.flatten [
        (nv' "<leader>tt" (cmd "NvimTreeToggle") "[T]oggle File[T]ree")
      ];
  };
}
