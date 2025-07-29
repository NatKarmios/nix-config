{ lib, ... }@args:
let
  modules = (import ./modules) args;
in
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings.mainBar = modules // {
      layer = "top";
      spacing = 10;
      modules-left = [
        "group/start"
        "group/datetime"
      ];
      modules-center = [
        "custom/notification"
        "niri/workspaces"
        "custom/note"
      ];
      modules-right = [
        "tray"
        "group/network"
        "pulseaudio"
        "battery"
      ];
    };
    style = lib.mkAfter (builtins.readFile ./style.css);
  };

  my.niri.startup-apps.waybar.cmd = ["systemctl" "--user" "reset-failed" "waybar.service"];

  stylix.targets.waybar.addCss = false;
}

