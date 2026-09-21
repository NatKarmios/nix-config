{ pkgs, config, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    sideloadInitLua = true; # Don't overwrite init.lua
    withRuby = true;
    withPython3 = true;
    withNodeJs = true;
    withPerl = true;
  };

  home.packages = with pkgs; [
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

  programs.zsh.shellAliases = {
    e = "nvim";
  };
}
