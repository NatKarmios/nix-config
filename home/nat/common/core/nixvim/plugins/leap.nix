# Super powered motion!
{ lib, ... }:
with lib.custom.nixvim;
{
  programs.nixvim = {
    plugins.leap = {
      enable = true;
      addDefaultMappings = false;
    };

    keymaps = with bind-helpers; [
      (nox "s" "<Plug>(leap)")
      (n "S" "<Plug>(leap-from-window)")
    ];
  };
}

