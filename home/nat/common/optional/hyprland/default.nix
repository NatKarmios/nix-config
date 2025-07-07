{ ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;

    # Conflicts with UWSM
    systemd.enable = false;

    settings = {
      input = {
        kb_layout = "gb";
        kb_options = "caps:backspace,shift:both_capslock";

        touchpad = {
          natural_scroll = true;
        };
      };

      "$mod" = "SUPER";
      bind = [
        "$mod, T, exec, uwsm app -- wezterm"
        "$mod, D, exec, rofi -show drun -run-command \"uwsm app -- {cmd}\""
      ];
    };
  };
}

