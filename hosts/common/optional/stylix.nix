#
# Automatic theming for many apps
#

{ inputs, pkgs, lib, ... }:
{
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    image = lib.custom.relativeToRoot "img/ds3.jpg";
    fonts = {
      serif.name = "Source Sans Pro";
      sansSerif.name = "Source Sans Pro";
      monospace.name = "0xProto Nerd Font";
    };
  };
}

