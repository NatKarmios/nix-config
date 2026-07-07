{ pkgs, ... }:
{
  home.packages = with pkgs; [
    affinity-v3
  ];
}
