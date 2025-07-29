{ lib, ... }:
{
  "group/start" = {
    modules = [
      "image#nixos"
      "custom/launch"
      "custom/apps"
      "custom/power"
    ];
    orientation = "horizontal";
    drawer = {};
  };
  "image#nixos" = {
    path = (lib.custom.relativeToRoot "img/NixOS.svg");
  };
  "custom/launch" = {
    format = "󰐌";
    justify = "center";
    tooltip-format = "Run action";
    on-click = "niri-quick-action";
  };
  "custom/power" = {
    format = "󰐥";
    justify = "center";
    tooltip-format = "Power menu";
  };
  "custom/apps" = {
    format = "󰀻";
    justify = "center";
    tooltip-format = "Start app";
  };
}

