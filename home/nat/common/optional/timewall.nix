{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    inputs.timewall.homeManagerModules.timewall
  ];

  home.packages = [ pkgs.swaybg ];

  services.timewall = {
    enable = true;
    package = pkgs.timewall;
    wallpaperPath = lib.custom.relativeToRoot "img/zelda.heic";
    config = {
      setter = {
        command = [
          "swaybg"
          "-o"
          "*"
          "-i"
          "%f"
          "-m"
          "fill"
        ];
        quiet = true;
        overlap = 1000;
      };
    };
  };
}
