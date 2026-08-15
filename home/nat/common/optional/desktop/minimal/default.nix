{ pkgs, lib, ... }:
{
  imports = [
    ./cursors.nix
    ./dankmaterialshell.nix
    ./displays.nix
    ./niri
    ./wezterm.nix
    ./wofi
  ];

  home.packages = with pkgs; [
    wev # show wayland events, also handy for detecting keypress codes
  ];

  xdg.autostart.enable = lib.mkDefault true;
}
