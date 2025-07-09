{ inputs, pkgs, lib, ... }:
{
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  stylix.enable = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
  stylix.image = lib.custom.relativeToRoot "img/swirls.jpg";
}

