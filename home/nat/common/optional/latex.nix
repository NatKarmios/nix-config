{ pkgs, ... }:
let
  texlive = pkgs.texlive.combined.scheme-full;
  zathura = pkgs.zathura;
in
{
  home.packages = [
    texlive
    zathura
  ];

  # programs.nixvim = {
  #   plugins = {
  #     vimtex = {
  #       enable = true;
  #       texlivePackage = texlive;
  #       zathuraPackage = zathura;
  #       settings.view_method = "zathura_simple";
  #     };
  #
  #     treesitter.settings.highlight.disable = [ "latex" ];
  #
  #     cmp.settings.sources = [
  #       { name = "vimtex"; }
  #     ];
  #   };
  #
  #   extraPlugins =
  #     let
  #       cmp-vimtex = pkgs.vimUtils.buildVimPlugin {
  #         name = "cmp-vimtex";
  #         src = pkgs.fetchFromGitHub {
  #           owner = "micangl";
  #           repo = "cmp-vimtex";
  #           rev = "5283bf9108ef33d41e704027b9ef22437ce7a15b";
  #           sha256 = "0damlf1gqinr1pbsc3jy43rpfz896780s9qapczr17vjv8yrsgd4";
  #         };
  #         doCheck = false;
  #       };
  #     in
  #     [ cmp-vimtex ];
  # };
}
