########################################################################
#                                                                      #
#  Surfux - Main Laptop (Microsoft Surface Book 3 15")                 #
#  NixOS running on Intel i7-1056G7, GeForce 1660Ti (Max-Q), 32GB RAM  #
#                                                                      #
########################################################################

{
  inputs,
  lib,
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
      "hosts/common/optional/brightnessctl.nix"
      "hosts/common/optional/desktop"
      "hosts/common/optional/lanzaboote.nix"
      "hosts/common/optional/stylix.nix"
      "hosts/common/optional/syncthing.nix"
      "hosts/common/optional/zerotier.nix"
    ])
  ];

  #
  # ========== Host specification ==========
  #

  hostSpec = {
    hostName = "surfux";
  };

  services.xserver.displayManager.lightdm.enable = false;
  services.logind.powerKey = "ignore";

  misc-tweaks.sddmFontSize = 18;

  # Prevent keyboard from sending BTN_0; this is interpreted as a
  #   mouse button and messed with compositors!
  environment.etc."libinput/local-overrides.quirks".text = pkgs.lib.mkForce ''
    [Microsoft Surface Book 3 Keyboard]
    MatchName=*Microsoft Surface *Keyboard*
    MatchDMIModalias=dmi:*svnMicrosoftCorporation:*
    AttrEventCode=-BTN_0;
  '';

  # Prioritise WiFi connections over Bluetooth tethering
  networking.networkmanager.settings = {
    connection-wifi = {
      match-device = "type:wifi";
      "ipv4.route-metric" = 100;
      "ipv6.route-metric" = 100;
    };

    connection-bluetooth = {
      match-device = "type:bt";
      "ipv4.route-metric" = 500;
      "ipv6.route-metric" = 500;
    };
  };

  boot.loader.efi.canTouchEfiVariables = true;

  system.stateVersion = "24.11";
}

