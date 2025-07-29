{ ... }:
{
  imports = [
    common/core
    common/optional/cursors.nix
    common/optional/discord.nix
    common/optional/git.nix
    common/optional/kdeconnect.nix
    common/optional/lazygit.nix
    common/optional/niri
    common/optional/obsidian.nix
    common/optional/onedrive
    common/optional/timewall.nix
    common/optional/waybar
  ];

  services.blueman-applet.enable = true;
}

