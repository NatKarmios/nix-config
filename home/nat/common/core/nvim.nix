{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    neovim
    neovim-remote
    tree-sitter
    vscode-langservers-extracted
  ];

  # Symlink my config
  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink
    "${config.home.sessionVariables.FLAKE}/nvim";
}
