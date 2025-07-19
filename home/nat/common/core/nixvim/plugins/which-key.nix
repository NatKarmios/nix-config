{ lib, ... }:
with lib.custom.nixvim;
{
  programs.nixvim.plugins.which-key = {
    enable = true;
    settings = {
      delay = 0;

      # Use icons if nerd font is enabled, otherwise use text prepresentations
      mappings = raw "vim.g.have_nerd_font";
      keys = raw ''
        vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        }
      '';

      # Document existing key chains
      spec = [
        { __unkeyed = "<leader>b"; group = "[B]uffer"; }
        { __unkeyed = "<leader>c"; group = "[C]ode"; }
        { __unkeyed = "<leader>f"; group = "[F]ind"; }
        { __unkeyed = "<leader>F"; group = "[F]ile"; }
        { __unkeyed = "<leader>t"; group = "[T]oggle"; }
        { __unkeyed = "<leader>w"; group = "[W]indow"; }
        { __unkeyed = "<leader>W"; group = "Tab"; }
      ];
    };
  };
}

