{ pkgs, ... }:
{
  imports = [
    ../common/core
    ../common/optional/affinity.nix
    ../common/optional/cursors.nix
    ../common/optional/dankmaterialshell.nix
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
    # ../common/optional/photoshop.nix
    ../common/optional/shells.nix
    # ../common/optional/timewall.nix
    ../common/optional/zotero

    ./displays.nix
  ];

  home.packages = with pkgs; [
    drawio
    rustdesk-flutter
  ];

  programs.niri.settings.debug.ignore-drm-device = "/dev/dri/renderD129";

  services.podman.enable = true;
}
