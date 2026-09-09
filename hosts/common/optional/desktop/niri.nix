{ inputs, pkgs, lib, ... }:
{
  imports = [
    inputs.niri.nixosModules.niri
  ];

  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };

  # The niri flake enables gnome-keyring, which cannot coexist with OpenSSH's agent
  programs.ssh.startAgent = lib.mkForce false;
}
