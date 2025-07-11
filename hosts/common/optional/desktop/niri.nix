{ inputs, pkgs, ... }:
let
  path = "/run/current-system/sw/bin";
  niri-uwsm = pkgs.writeShellScriptBin "niri-uwsm" ''
    exec ${path}/uwsm start -S -F ${path}/niri
  '';
  desktop-entry = pkgs.writeTextFile {
    name = "niri-uswm";
    text = ''
      [Desktop Entry]
      Name=Niri (UWSM)
      Comment=A scrolling window manaver (with UWSM, manual desktop entry)
      Exec=${path}/niri-uwsm
    '';
    destination = "/share/wayland-sessions/niri-uwsm.desktop";
    derivationArgs = {
      passthru.providedSessions = [ "niri-uwsm" ];
    };
  };
in
{
  imports = [
    inputs.niri-flake.nixosModules.niri
  ];

  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };

  environment.systemPackages = [ niri-uwsm ];

  services.displayManager.sessionPackages = [
    desktop-entry
  ];

  security.pam.services.swaylock = {};
}

