#
# File manager
#

{ lib, ... }:
with lib.custom.nixvim;
{
  programs.nixvim = {
    plugins.yazi = {
      enable = true;
      settings.open_for_directories = true; # Use Yazi when "opening" direcories in nvim
    };

    keymaps =
      with bind-helpers;
      lib.flatten [
        (n' "<leader>oy" (cmd "Yazi") "[O]pen [Y]azi")
      ];
  };
}
