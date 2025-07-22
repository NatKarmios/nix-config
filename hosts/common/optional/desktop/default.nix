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
    uwsm
    libinput
    wl-clipboard-rs
  ];

  fonts.packages = with pkgs; [
    fira-code
    nerd-fonts.fira-code
    source-sans-pro
  ];
}
