{ inputs, pkgs, ... }:
let
  path = "/run/current-system/sw/bin";
  hyprland-uwsm = pkgs.writeShellScriptBin "hyprland-uwsm" ''
    exec ${path}/uwsm start -S -F ${path}/hyprland
  '';
  desktop-entry = pkgs.writeTextFile {
    name = "hyprland-uswm";
    text = ''
      [Desktop Entry]
      Name=Hyprland (UWSM)
      Comment=Dynamic tiling Wayland compositor that doesn't sacrifice on its looks (with UWSM, manual desktop entry)
      Exec=${path}/hyprland-uwsm
    '';
    destination = "/share/wayland-sessions/hyprland-uwsm.desktop";
    derivationArgs = {
      passthru.providedSessions = [ "hyprland-uwsm" ];
    };
  };
in
{
  programs.hyprland.enable = true;
  programs.hyprlock.enable = true;
  services.hypridle.enable = true;

  environment.systemPackages = [ hyprland-uwsm ];

  services.displayManager.sessionPackages = [
    desktop-entry
  ];
}

