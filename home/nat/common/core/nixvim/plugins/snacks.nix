# Various quality-of-life enhancements
{ lib, ... }:
with lib.custom.nixvim;
{
  programs.nixvim = {
    plugins.snacks = {
      enable = true;
      settings.lazygit.enabled = true;
    };

    keymaps =
      with bind-helpers;
      lib.flatten [
        (n' "<leader>og" (rawFn "Snacks.lazygit.open()") "[O]pen Lazy[G]it")
      ];
  };
}
