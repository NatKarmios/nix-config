{ lib, ... }@args:
{
  battery = {
    format = "{icon}  {capacity}%";
    format-full = "󰁹";
    format-icons = {
      default = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
      charging = ["󰢟" "󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅"];
    };
  };
  pulseaudio = {
    format = "{icon}  {volume}%";
    format-muted = "󰝟";
    format-icons = ["󰕿" "󰖀" "󰕾"];
  };
  "custom/note" = {
    format = "󰏫";
    justify = "center";
  };
} // lib.mergeAttrsList (map (p: (import p) args) [
  ./datetime.nix
  ./network.nix
  ./notification.nix
  ./start.nix
])

