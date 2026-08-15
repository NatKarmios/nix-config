{ hostSpec, ... }:
{
  imports = [
    ../common/core

    ../common/optional/ai
    ../common/optional/desktop/extra
    ../common/optional/dev/extra
    ../common/optional/onedrive
    ../common/optional/sops.nix
    ../common/optional/ssh.nix
    ../common/optional/term-extra

    ./displays.nix
  ];

  inherit hostSpec;


  programs.niri.settings.debug.ignore-drm-device = "/dev/dri/by-path/pci-0000:02:00.0-render";

  services.podman.enable = true;
}
