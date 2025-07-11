{ pkgs, ... }:
{
  imports = [
    ./firefox.nix
    ./gnome.nix
    #./hyprland.nix
    ./niri.nix
    ./sddm.nix
    ./pipewire.nix
  ];

  environment.systemPackages = with pkgs; [
    uwsm
    libinput

    # Fonts
    fira-code
    nerd-fonts.fira-code
    source-sans-pro
  ];
}
