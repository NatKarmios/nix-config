{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    neovim
    neovim-remote
    tree-sitter
    vscode-langservers-extracted
    lsof
  ];

  # Symlink my config
  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.sessionVariables.FLAKE}/nvim";

  # Nix-managed lua config
  xdg.configFile."nvim-nix/init.lua".text = ''
    -- This file is managed by Nix
  '';

  home.sessionVariables = {
    VISUAL = "nvim";
    EDITOR = "nvim";
  };

  programs.zsh.shellAliases = {
    e = "nvim";
    vi = "nvim";
    vim = "nvim";
  };
}
