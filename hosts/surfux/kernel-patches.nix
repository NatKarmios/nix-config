# Custom kernel patches for Microsoft Surface devices
# https://github.com/linux-surface/linux-surface
{ inputs, ... }:
{
  imports = [
    inputs.hardware.nixosModules.microsoft-surface-common
  ];

  hardware.microsoft-surface.kernelVersion = "stable";
}
