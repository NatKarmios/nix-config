{ pkgs, ... }:
{
  imports = [
    ./firefox.nix
    ./gnome.nix
    ./niri.nix
    ./sddm.nix
    ./sleepy.nix
    ./pipewire.nix
  ];

  environment.systemPackages = with pkgs; [
    libinput
    wl-clipboard-rs
  ];

  fonts.packages = with pkgs; [
    fira-code
    nerd-fonts.fira-code
    nerd-fonts._0xproto
    source-sans-pro
  ];
}
