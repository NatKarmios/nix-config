# Wayland display management

{ pkgs, config, ... }:
let
  wdisplays = pkgs.wdisplays;
in
{
  # Automatic display layout with kanshi
  services.kanshi = {
    enable = true;
    settings =
      with config.my.kanshi;
      outputs ++ profiles ++ other-settings;
  };

  # Manual display layout with wdisplays
  home.packages = [ wdisplays ];
  my.niri.quick-actions.displays = {
    desc = "Manage display layout";
    cmd = [ "${wdisplays}/bin/wdisplays" ];
  };
}
