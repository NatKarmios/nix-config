{ pkgs, ... }:
{
  imports = [
    ./dank-greeter.nix
    ./firefox.nix
    ./gnome.nix
    ./niri.nix
    ./pipewire.nix
    ./sleepy.nix
  ];

  environment.systemPackages = with pkgs; [
    libinput
    wl-clipboard-rs
    vscode
    # klogg
  ];

  fonts.packages = with pkgs; [
    cm_unicode
    nerd-fonts.fira-code
    nerd-fonts._0xproto
    source-sans-pro

    # Needed for DankMaterialShell
    fira-code
    material-symbols
    inter
  ];

  # For KDE Connect
  networking.firewall = rec {
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
    allowedUDPPortRanges = allowedTCPPortRanges;
  };
}
