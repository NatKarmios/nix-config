#
# Quick, versatile GUI menus
#

{ pkgs, ... }:
{
  programs.rofi.enable = true;
  programs.rofi.package = pkgs.rofi-wayland;
}

