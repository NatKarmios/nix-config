{
  imports = [
    ./firefox.nix
    ./gnome.nix
    ./hyprland.nix
    ./niri.nix
    ./sddm.nix
    ./pipewire.nix
  ];

  #services.xserver.displayManager.gdm.enable = true;
}
