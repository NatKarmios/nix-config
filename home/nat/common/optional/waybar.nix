{ pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    settings = [{
      modules-left = [
        "niri/workspaces"
      ];
      modules-center = [
        "niri/window"
      ];
      modules-right = [
        "tray"
        "backlight"
        "pulseaudio"
        "battery"
        "clock"
      ];
    }];
  };
}

