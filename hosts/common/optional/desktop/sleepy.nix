{ pkgs, config, ... }:
with pkgs;
{
  environment.systemPackages =
    if config.hostSpec.isLaptop then
      [
        acpi
        (writeShellScriptBin "sleepy" ''
          if [[ $(acpi -a | grep -o 'on-line') == 'on-line' ]]; then
            echo "The device is charging; not suspending."
          else
            systemctl suspend
          fi
        '')
      ]
    else
      [
        (writeShellScriptBin "sleepy" ''
          systemctl suspend
        '')
      ];
}
