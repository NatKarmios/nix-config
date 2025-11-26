{ inputs, system, ... }:
{
  imports = [
    inputs.dankMaterialShell.homeModules.dankMaterialShell.default
    inputs.dankMaterialShell.homeModules.dankMaterialShell.niri
  ];

  programs.dankMaterialShell = {
    enable = true;
    # quickshell.package = inputs.quickshell.packages.${system}.default;

    systemd.enable = true;
    enableSystemMonitoring = true;
    enableClipboard = true;
    enableVPN = true;
    enableBrightnessControl = true;
    enableColorPicker = true;
    enableDynamicTheming = true;
    enableAudioWavelength = true;
    enableCalendarEvents = true;
    enableSystemSound = true;

    niri = {
      enableKeybinds = false;
      enableSpawn = false;
    };
  };
}
