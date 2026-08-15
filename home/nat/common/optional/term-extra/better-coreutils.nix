{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bat # better cat/less
    bat-extras.core
    eza # better ls
    uutils-coreutils-noprefix # Rust reqrite of GNU coreutils
  ];

  programs.zsh.shellAliases = {
    less = "bat";

    l = "eza -lah";
    la = "eza -lah";
    ll = "eza -lh";
    ls = "eza";
    lsa = "eza -lah";
  };
}

