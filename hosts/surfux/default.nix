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
  config,
  ...
}:
{
  imports = lib.flatten [
    #
    # ========== Hardware ==========
    #
    ./hardware-configuration.nix
    ./nvidia.nix
    ./displaylink.nix
    ./power-tweaks.nix
    # ./kernel-patches.nix

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
    isLaptop = true;
  };

  services.xserver.displayManager.lightdm.enable = false;
  services.logind.settings.Login.HandlePowerKey = "suspend";

  misc-tweaks.sddmFontSize = 18;

  environment.systemPackages = [ pkgs.surface-control ];

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

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;
  users.users.${config.hostSpec.username}.extraGroups = [
    "networkmanager"
    "lp"
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    package = pkgs.steam.override {
      extraArgs = "-system-composer";

      # nvidia-offload equivalent
      extraEnv = {
        __NV_PRIME_RENDER_OFFLOAD = 1;
        __NV_PRIME_RENDER_OFFLOAD_PROVIDER = "NVIDIA-G0";
        __GLX_VENDOR_LIBRARY_NAME = "nvidia";
        __VK_LAYER_NV_optimus = "NVIDIA_only";
      };
    };
  };

  boot.loader.efi.canTouchEfiVariables = true;

  system.stateVersion = "24.11";
}
