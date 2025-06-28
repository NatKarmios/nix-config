########################################################################
#                                                                      #
#  Surfux - Main Laptop (Microsoft Surface Book 3 15")                 #
#  NixOS running on Intel i7-1056G7, GeForce 1660Ti (Max-Q), 32GB RAM  #
#                                                                      #
########################################################################

{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = lib.flatten [
    #
    # ========== Hardware ==========
    #
    ./hardware-configuration.nix
    inputs.hardware.nixosModules.microsoft-surface-common

    (map lib.custom.relativeToRoot [
      #
      # ========== Required config ==========
      #
      "hosts/common/core"

      #
      # ========== Optional config ==========
      #
      "hosts/common/optional/stylix.nix"
      "hosts/common/optional/desktop"
      "hosts/common/optional/brightnessctl.nix"
      #(map (f: "hosts/common/optional/${f}") [
      #  "stylix.nix"
      #  "desktop"
      #  "brightnessctl.nix"
      #])
    ])
  ];

  #
  # ========== Host specification ==========
  #

  hostSpec = {
    hostName = "surfux";
  };

  services.xserver.displayManager.lightdm.enable = false;

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  system.stateVersion = "24.11";
}

