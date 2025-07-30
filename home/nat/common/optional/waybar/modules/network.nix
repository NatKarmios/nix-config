{ pkgs, ... }:
{
  "group/network" = {
    modules = [
      "custom/other-networks"
      "custom/wifi"
    ];
    orientation = "horizontal";
  };

  "custom/other-networks" = {
    interval = 3;
    hide-empty-text = true;
    exec = pkgs.writeShellScript "waybar-custom-other-networks" (
      builtins.readFile ../scripts/get-other-network-icons.bash
    );
  };

  "custom/wifi" = {
    interval = 3;
    exec = pkgs.writeShellScript "waybar-custom-wifi" (
      builtins.readFile ../scripts/get-wifi-status.bash
    );
  };
}
