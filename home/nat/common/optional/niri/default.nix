{ lib, config, ... }:
let
  l-if = cond: elem: if cond then [ elem ] else [];
in
{
  imports = [
    ./binds.nix
    ./idle.nix
    ./lock.nix
  ];

  services.mako.enable = true;

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
    };

    spawn-at-startup = lib.flatten [
      { command = ["uwsm" "app" "--" "waybar"]; }
      { command = ["uwsm" "app" "--" "obsidian"]; }
      { command = ["uwsm" "app" "--" "vesktop"]; }
      { command = ["uwsm" "finalize"]; }
    ];

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
  };
}

