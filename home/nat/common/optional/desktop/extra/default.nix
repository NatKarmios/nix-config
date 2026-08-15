{ pkgs, ... }:
{
  imports = [
    ../core

    ./affinity.nix
    ./zotero
  ];

  home.packages = with pkgs; [
    drawio
    slack
  ];
}
