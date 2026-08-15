{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bottom # system monitor
    copyq # clipboard manager
    dust # disk usage
    fastfetch # pretty system info
    fd # tree-style ls
    gum # a bunch of helpful utilities for shell scripting
    ncdu # TUI disk usage
    procs # better ps
    sd # simpler cut / awk
    systemctl-tui
    tldr # quick examples of shell commands
    tree # cli dir tree viewer
  ];

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultOptions = [ "--tmux center" ];
  };
}
