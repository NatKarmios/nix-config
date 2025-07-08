{ pkgs, ... }:
{
  imports = [
    common/core
    common/optional/discord.nix
    common/optional/hyprland
    common/optional/niri
    common/optional/waybar.nix
  ];

  home.packages = with pkgs; [
    obsidian
  ];
}

