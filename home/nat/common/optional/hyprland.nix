{ ... }:
{
  wayland.windowManager.hyperland = {
    enable = true;
    settings = {
      bind = [
        "SUPER, T, exec, wezterm"
      ];
    };
  };
}

