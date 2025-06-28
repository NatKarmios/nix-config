{ inputs, pkgs, ... }:
{
  imports = [
    inputs.niri-flake.nixosModules.niri
  ];

  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };

  programs.uwsm.waylandCompositors.niri = {
    prettyName = "Niri";
    comment = "A scrolling window manager (with UWSM)";
    binPath = "/run/current-system/sw/bin/niri";
  };
}

