#
# Quick, versatile GUI menus
#

{ pkgs, ... }:
let
  wofi-app = pkgs.writeShellScriptBin "wofi-app" ''
    wofi --allow-images --columns=4 --show drun -a
  '';
in
{
  programs.wofi = {
    enable = true;
    style = builtins.readFile ./style.css;
  };

  stylix.targets.wofi.enable = false;

  home.packages = [ wofi-app ];
}

