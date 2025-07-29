{ pkgs, ... }:
{
  home.packages = [ pkgs.kdePackages.kdeconnect-kde ];
  services.kdeconnect = {
    enable = true;
    indicator = true;
  };
}

