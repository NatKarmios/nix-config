{ pkgs, ... }:
{
  home.packages = with pkgs; [
    curl
    findutils # find
    jq # json pretty-printer and manipulator
    osc # copy/paste system clipboard in the terminal
    p7zip
    ripgrep # better grep
    unzip
    unrar
    wget
    yq-go # jq for yaml
    zip
  ];
}
