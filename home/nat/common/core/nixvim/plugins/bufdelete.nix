{ lib, ... }:
with lib.custom.nixvim;
let
  abbrev = from: to: ''
    cabbrev ${from} <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? '${to}' : '${from}')<CR>
  '';
in
{
  programs.nixvim = {
    plugins.bufdelete.enable = true;

    extraConfigVim = ''
      ${abbrev "bd" "Bdelete"}
      ${abbrev "bd!" "Bdelete!"}
      ${abbrev "bw" "Bwipeout"}
    '';

    keymaps =
      with bind-helpers;
      lib.flatten [
        (n' "<leader>bd" (cmd "Bdelete") "[B]uffer [D]elete")
      ];
  };
}
