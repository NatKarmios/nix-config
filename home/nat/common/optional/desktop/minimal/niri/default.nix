#
# Scrolling window manager
#

{
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./binds.nix
    ./quick-actions.nix
  ];

  home.packages = [ pkgs.xwayland-satellite ];
  my.niri.startup-apps.xwayland-satellite = {
    cmd = "xwayland-satellite";
  };

  programs.niri.settings = {
    input = {
      keyboard.xkb = {
        layout = "gb";
        options = "caps:backspace,shift:both_capslock";
      };

      mouse = {
        accel-speed = null;
      };

      touchpad = {
        tap = true;
        natural-scroll = true;
      };

      power-key-handling.enable = false;
    };

    environment = {
      "NIXOS_OZONE_WL" = "1";
      "DISPLAY" = ":0";
    };

    cursor = {
      theme = "Posy_Cursor_Black";
    };

    spawn-at-startup =
      config.my.niri.startup-apps
      |> lib.attrValues
      |> builtins.filter (a: a.enable)
      |> map (a: {
        command = a.cmd;
      });

    layout = {
      gaps = 8;
      center-focused-column = "never";

      preset-column-widths = [
        { proportion = 1. / 3.; }
        { proportion = 1. / 2.; }
        { proportion = 2. / 3.; }
      ];

      default-column-width.proportion = 0.5;

      focus-ring = {
        # stylix integration disables this by default
        enable = true;

        width = 2;
        active.gradient = {
          from = "#18b6f6";
          to = "#8000ff";
          angle = 150;
        };
        inactive.color = "#505050";
      };

      # stylix integration enables this by default
      border.enable = false;
    };
    overview.backdrop-color = "#1e1e2e";
    hotkey-overlay.skip-at-startup = true;
  };
}
