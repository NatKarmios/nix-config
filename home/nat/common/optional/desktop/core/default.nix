{ pkgs, ... }:
{
  imports = [
    ../minimal

    ./discord.nix
    ./flameshot.nix
    ./kdeconnect.nix
    ./obsidian.nix
  ];

  home.packages = with pkgs; [
    rustdesk-flutter
  ];
}
