{
  programs.vesktop = {
    enable = true;
    settings = {
      customTitleBar = true;
      disableMinSize = true;
    };
    vencord = {
      themes.natppuccin = ''
        /**
        * @name Natppuccin
        * @author Nat
        * @description Some fixes for Stylix's Catppuccin Mocha base16 theme.
        **/

        * {
          --header-primary: #cdd6f4;
          --header-secondary: #a6adc8;
          --text-secondary: #a6adc8;
          --text-tertiary: #7f849c;
          --channel-icon: #7f849c;
          --channels-default: #7f849c;
          --text-link: #89b4fa;
          --brand-500: #8839ef;
          --status-danger: #e64553;
          --control-background-primary-default: #8839ef;
          --font-code: "0xProto Nerd Font", monospace;
        }
      '';
      settings.enabledThemes = [ "natppuccin.css" ];
    };
  };

  ## Vesktop starts before DMS, so its tray icon doesn't show. This is a DMS bug:
  ## https://github.com/AvengeMedia/DankMaterialShell/issues/1073
  # my.niri.startup-apps.vesktop.cmd = [
  #   "vesktop"
  #   "--start-minimized"
  # ];
}
