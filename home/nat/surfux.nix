{ ... }:
{
  imports = [
    common/core
    common/optional/discord.nix
    common/optional/git.nix
    common/optional/lazygit.nix
    common/optional/obsidian.nix
    common/optional/onedrive
    common/optional/niri
    common/optional/waybar.nix
  ];

  services.blueman-applet.enable = true;
}

