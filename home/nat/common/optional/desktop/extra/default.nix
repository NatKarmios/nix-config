{ pkgs, ... }:
{
  imports = [
    ../core

    ./affinity.nix
    ./zotero
  ];

  home.packages = with pkgs; [
    drawio
    signal-desktop
    slack
    ytmdesktop
    zulip
  ];
}
