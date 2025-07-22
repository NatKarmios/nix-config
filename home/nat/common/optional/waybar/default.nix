{ lib, ... }@args:
let
  modules = (import ./modules) args;
in
{
  programs.waybar = {
    enable = true;
    settings = [({
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
    } // modules)];
    style = lib.mkAfter (builtins.readFile ./style.css);
  };

  stylix.targets.waybar.addCss = false;
}

