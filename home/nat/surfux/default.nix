{ pkgs, ... }:
{
  imports = [
    ../common/core
    ../common/optional/cursors.nix
    ../common/optional/discord.nix
    ../common/optional/displays.nix
    ../common/optional/flameshot.nix
    ../common/optional/git.nix
    ../common/optional/kdeconnect.nix
    ../common/optional/lazygit.nix
    ../common/optional/latex.nix
    ../common/optional/niri
    ../common/optional/obsidian.nix
    ../common/optional/onedrive
    ../common/optional/photoshop.nix
    ../common/optional/shells.nix
    ../common/optional/timewall.nix
    ../common/optional/waybar
    ../common/optional/zotero

    ./displays.nix
  ];

  home.packages = with pkgs; [
    drawio
  ];

  services.blueman-applet.enable = true;
  services.network-manager-applet.enable = true;
}
