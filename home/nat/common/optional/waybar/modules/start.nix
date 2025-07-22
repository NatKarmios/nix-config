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
    format = "󰼛";
    tooltip-format = "Run action";
  };
  "custom/power" = {
    format = "󰐥";
    tooltip-format = "Power menu";
  };
  "custom/apps" = {
    format = "󰀻";
    tooltip-format = "Start app";
  };
}

