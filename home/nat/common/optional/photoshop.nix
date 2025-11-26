{ pkgs, inputs, system, ... }:
{
  home.packages = [
    (pkgs.photoshop.override {
      wine = pkgs.wineWowPackages.stable;
      uiScale = "192";
      src = pkgs.requireFile inputs.nix-secrets.photoshopSrc;
    })
    inputs.erosanix.packages.${system}.mkwindowsapp-tools
  ];
}
