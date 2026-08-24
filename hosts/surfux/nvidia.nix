{
  # Enable OpenGL
  hardware.graphics.enable = true;

  services.xserver.videoDrivers = [
    "modesetting"
    "nvidia"
  ];

  hardware.nvidia = {
    open = true;
    branch = "latest"; # Need >= 610.43.02 for D3cold on 1650Ti

    nvidiaSettings = true;

    # GPU offloading
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:2:0:0";
    };

    # Needed to suspend GPU and save power when not in use
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = true;
  };

  # Also needed to enable suspending
  boot.extraModprobeConfig = ''
    options nvidia NVreg_EnableS0ixPowerManagement=1 NVreg_DynamicPowerManagement=0x02
  '';
}
