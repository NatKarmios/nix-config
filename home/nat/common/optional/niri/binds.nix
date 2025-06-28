{ config, lib, ... }:
let
  merge = lib.mergeAttrsList;
  prepend = lib.custom.prependAttrNames;
  mod = prepend "Mod+";
  mod-shift = prepend "Mod+Shift+";
  shift = prepend "Shift+";
  ctrl = prepend "Ctrl+";
  attrsForRange = a: b: f: lib.listToAttrs (map f (lib.range a b));
in
{
  programs.niri.settings.binds = with config.lib.niri.actions; merge [
    (mod (merge [
      # Misc Niri actions
      {
        "O" = {
          action = toggle-overview;
          repeat = false;
        };
        "Q" = {
          action = close-window;
          repeat = false;
        };
      }
  
      # Important apps
      {
        "T".action = spawn "wezterm";
        "D".action = spawn "firefox";
      }
  
      # Basic navigation
      (merge [
        {
          "Left".action = focus-column-left;
          "Right".action = focus-column-right;
          "Up".action = focus-window-up;
          "Down".action = focus-window-down;
          "H".action = focus-column-left;
          "J".action = focus-column-right;
          "K".action = focus-window-up;
          "L".action = focus-window-down;
  
          "Home".action = focus-column-first;
          "End".action = focus-column-last;
  
          "C".action = center-column;
          "Ctrl+C".action = center-visible-columns;
  
          "WheelScrollDown" = {
            action = focus-workspace-down;
            cooldown-ms = 150;
          };
          "WheelScrollUp" = {
            action = focus-workspace-up;
            cooldown-ms = 150;
          };
          
          "Page_Down".action = focus-workspace-down;
          "Page_Up".action = focus-workspace-up;
          "U".action = focus-workspace-down;
          "I".action = focus-workspace-up;
        }
        (attrsForRange 1 10 (i: {
          name = builtins.toString (lib.custom.mod i 10);
          value.action = focus-workspace i;
        }))
        (ctrl {
          "Left".action = focus-monitor-left;
          "Right".action = focus-monitor-right;
          "Up".action = focus-monitor-up;
          "Down".action = focus-monitor-down;
          "H".action = focus-monitor-left;
          "J".action = focus-monitor-right;
          "K".action = focus-monitor-up;
          "L".action = focus-monitor-down;
        })
      ])
  
      # Moving windows & columns
      (shift (merge [
        {
          "Left".action = move-column-left;
          "Right".action = move-column-right;
          "Up".action = move-window-up;
          "Down".action = move-window-down;
          "H".action = move-column-left;
          "J".action = move-column-right;
          "K".action = move-window-up;
          "L".action = move-window-down;
  
          "Home".action = move-column-to-first;
          "End".action = move-column-to-last;
  
          "Page_Down".action = move-column-to-workspace-down;
          "Page_Up".action = move-column-to-workspace-up;
          "U".action = move-column-to-workspace-down;
          "I".action = move-column-to-workspace-up;
        }
        (attrsForRange 1 10 (i: {
          name = builtins.toString (lib.custom.mod i 10);
          # https://github.com/sodiboo/niri-flake/issues/1018
          value.action.move-column-to-workspace = i;
        }))
        (ctrl {
          "Left".action = move-column-to-monitor-left;
          "Right".action = move-column-to-monitor-right;
          "Up".action = move-column-to-monitor-up;
          "Down".action = move-column-to-monitor-down;
          "H".action = move-column-to-monitor-left;
          "J".action = move-column-to-monitor-right;
          "K".action = move-column-to-monitor-up;
          "L".action = move-column-to-monitor-down;
        })
        {
          # Move the focused window in and out of a column.
          # If the window is alone, into the nearby column to the side.
          # If the window is already in a column, expel it out.
          "BracketLeft".action = consume-or-expel-window-left;
          "BracketRight".action = consume-or-expel-window-right;
  
          # Consume a window from the right to the bottom of the focused column.
          "Comma".action = consume-window-into-column;
          # Expel the bottom window from the focused column to the right.
          "Period".action = expel-window-from-column;
        }
      ]))
  
      # Resizing windows & columns
      (let
        resizeDelta = 10;
        d = (toString resizeDelta) + "%";
      in
      {
        "R".action = switch-preset-column-width;
        "Shift+R".action = switch-preset-window-height;
        "Ctrl+R".action = reset-window-height;
  
        "F".action = maximize-column;
        "Shift+F".action = expand-column-to-available-width;
        "Ctrl+F".action = fullscreen-window;
  
        # Percentage of screen width/height
        "Minus".action = set-column-width "-${d}";
        "Plus".action = set-column-width "+${d}";
        "Shift+Minus".action = set-window-height "-${d}";
        "Shift+Plus".action = set-window-height "+${d}";
      })
  
      # Layout
      {
        "V".action = toggle-window-floating;
        "Ctrl+V".action = switch-focus-between-floating-and-tiling;
      }
    ]))
  
    # Media keys
    {
      "XF86AudioRaiseVolume" = {
        action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+";
        allow-when-locked = true;
      };
      "XF86AudioLowerVolume" = {
        action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-";
        allow-when-locked = true;
      };
      "XF86AudioMute" = {
        action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
        allow-when-locked = true;
      };
      "XF86AudioMicMute" = {
        action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";
        allow-when-locked = true;
      };
  
      "XF86MonBrightnessUp" = {
        action = spawn "brightnessctl" "--class=backlight" "set" "+10%";
        allow-when-locked = true;
      };
      "XF86MonBrightnessDown" = {
        action = spawn "brightnessctl" "--class=backlight" "set" "10%-";
        allow-when-locked = true;
      };
    }
  
    # Exiting
    {
      "Mod+Shift+E".action = quit;
      "Ctrl+Alt+Delete".action = quit;
    }
  ];
}

