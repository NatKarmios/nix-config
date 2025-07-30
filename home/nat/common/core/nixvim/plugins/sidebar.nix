{ pkgs, lib, ... }:
with lib.custom.nixvim;
{
  programs.nixvim = {
    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        name = "sidebar";
        src = pkgs.fetchFromGitHub {
          owner = "sidebar-nvim";
          repo = "sidebar.nvim";
          rev = "082e4903c1659a65e27a075b752178b0c56fffb2";
          sha256 = "04razzm4k1bvalphh4xv32nd7jqvi89mbm45143l9sczg67sq4pl";
        };
      })
    ];

    extraConfigLua = ''
      local sidebar = require("sidebar-nvim")
      sidebar.setup({
        section_separator = function(section, index)
          return {
            "",
            string.rep("─", sidebar.get_width()),
          }
        end,
        sections = {
          "buffers",
          "git",
        },
      })
    '';

    keymaps =
      with bind-helpers;
      lib.flatten [
        (nv' "<leader>ts" (cmd "SidebarNvimToggle") "[T]oggle [S]idebar")
      ];
  };
}
