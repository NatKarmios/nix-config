{ ... }:
{
  imports = [
    common/core
    common/optional/cursors.nix
    common/optional/discord.nix
    common/optional/flameshot.nix
    common/optional/git.nix
    common/optional/kdeconnect.nix
    common/optional/lazygit.nix
    common/optional/niri
    common/optional/obsidian.nix
    common/optional/onedrive
    common/optional/timewall.nix
    common/optional/waybar
    common/optional/zotero
  ];

  services.blueman-applet.enable = true;
  services.network-manager-applet.enable = true;

  programs.niri.settings.outputs."eDP-1".scale = 1.75;
}

