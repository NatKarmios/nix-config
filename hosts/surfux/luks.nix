{
  boot.initrd.luks.devices.cryptroot.device = "/dev/disk/by-uuid/051b3669-2170-48fe-a379-f4aa88caa8a7";

  # Surface Book 3; enable the keyboard to enter LUKS password!
  boot.initrd.availableKernelModules = [
    "intel_lpss"
    "intel_lpss_pci"
    "pinctrl_icelake"
    "surface_aggregator"
    "surface_aggregator_registry"
    "surface_aggregator_hub"
    "surface_hid_core"
    "8250_dw"
    "surface_hid"
  ];
}
