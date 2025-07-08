{ pkgs, config, ... }:
let
  path = "/run/current-system/sw/bin";

  # Bodge: use local development Niri while I try to figure out
  #   the mouse input bug.
  local-path = "/home/${config.hostSpec.username}/src/niri";
  niri-local = pkgs.writeShellScriptBin "niri-local" ''
    exec nix develop git+file://${local-path} --command cargo run --manifest-path=${local-path}/Cargo.toml
  '';
  niri-local-uwsm = pkgs.writeShellScriptBin "niri-local-uwsm" ''
    exec ${path}/uwsm start -S -F ${path}/niri-local
  '';
  desktop-entry = pkgs.writeTextFile {
    name = "niri-uswm-local";
    text = ''
      [Desktop Entry]
      Name=Nat's Niri (UWSM)
      Comment=God help me
      Exec=${path}/niri-local-uwsm
    '';
    destination = "/share/wayland-sessions/niri-local-uwsm.desktop";
    derivationArgs = {
      passthru.providedSessions = [ "niri-local-uwsm" ];
    };
  };
in
{
  environment.systemPackages = [ niri-local niri-local-uwsm ];

  services.displayManager.sessionPackages = [
    desktop-entry
  ];
}

