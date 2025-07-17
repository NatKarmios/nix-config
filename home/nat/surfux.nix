{ pkgs, ... }:
{
  imports = [
    common/core
    common/optional/discord.nix
    common/optional/git.nix
    common/optional/lazygit.nix
    common/optional/onedrive
    common/optional/niri
    common/optional/waybar.nix
  ];

  home.packages = with pkgs; [
    obsidian
  ];
}

